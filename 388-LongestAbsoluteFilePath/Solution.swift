import Foundation

class File {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Directory {
    var parent: Directory?
    var path: String
    var subdirectories: [Directory] = []
    var files: [File] = []
    
    init(parent: Directory?, path: String) {
        self.parent = parent
        self.path = path
    }
    
    var absolutePaths: [String] {
        var result: [String] = []
        for file in files {
            result.append(path + (!path.isEmpty ? "/" : "") + file.name)
        }
        
        for directory in subdirectories {
            result.append(contentsOf: directory.absolutePaths)
        }
        return result
    }
}

class Solution {
    // Each directory name consists of letters, digits, and/or spaces.
    // Each file name is of the form name.extension, where name and extension
    // consist of letters, digits, and/or spaces.
    let tabCharacterSet = CharacterSet(charactersIn: "\t")

    func tokenize(_ input: String) -> [Substring] {
        // This isn't true tokenization, but it stuck
        // around because it was initally a way for me
        // to contextualize the problem.
        input.split(separator: "\n")
    }
    
    func parse(_ tokens: [Substring]) -> Directory {
        // liberal usage of ArraySlice is a great way
        // to avoid unnecessary allocations. COW will
        // only take you so far.
        var tokens = ArraySlice(tokens)
        var root: Directory = Directory(parent: nil, path: "")
        var currentDirectory = root
        var depth = 0
        while !tokens.isEmpty {
            if let (dir, remaining) = parseDirectory(
                parent: currentDirectory,
                path: currentDirectory.path,
                tokens: tokens
            ) {
                currentDirectory.subdirectories.append(dir)
                tokens = remaining
            } else if let (file, remaining) = parseFile(tokens) {
                currentDirectory.files.append(file)
                tokens = remaining
            } else {
                fatalError("parsing error")
            }
            
            if let nextDepth = tokens.first?.prefix(while: { $0 == "\t" }).count, nextDepth != depth {
                if nextDepth > depth {
                    // descend the tree to next directory context
                    // we're guaranteed to have a subdirectory if we're descending.
                    currentDirectory = currentDirectory.subdirectories.last!
                } else {
                    // ascend the tree to new directory context
                    // We're guaranteed to have a parent at the given depth,
                    // because we can't have a negative number of tab
                    // characters in the next token
                    for _ in 0..<depth - nextDepth {
                        currentDirectory = currentDirectory.parent!
                    }
                }
                depth = nextDepth
            }
        }
        
        return root
    }
    
    // There is some special name for these function types & names,
    // and they're adjacent to "Parser Combinators", but I forget what
    // the name of the actual technique is.
    
    func parseDirectory(
        parent: Directory?,
        path: String,
        tokens: ArraySlice<Substring>
    ) -> (Directory, ArraySlice<Substring>)? {
        guard let token = tokens.first, !token.contains(".") else { return nil }
        let dir = Directory(
            parent: parent,
            path: path + (!path.isEmpty ? "/" : "") + String(token.trimmingCharacters(in: tabCharacterSet))
        )
        return (dir, tokens.dropFirst())
    }
    
    func parseFile(
        _ tokens: ArraySlice<Substring>
    ) -> (File, ArraySlice<Substring>)? {
        guard let token = tokens.first, token.contains(".") else { return nil }
        let file = File(name: String(token.trimmingCharacters(in: tabCharacterSet)))
        return (file, tokens.dropFirst())
    }
    
    func lengthLongestPath(_ input: String) -> Int {
        let tokens = tokenize(input)
        let filesystem = parse(tokens)
        // Just count the length of the absolute paths, and pick the biggest one.
        return filesystem.absolutePaths.map(\.count).max() ?? 0
    }
}

let solution = Solution()
solution.lengthLongestPath("dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext")
solution.lengthLongestPath("file1.txt\nfile2.txt\nlongfile.txt")

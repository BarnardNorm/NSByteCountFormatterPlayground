// Displaying Byte Counts using `NSByteCountFormatter`
// Norm Barnard
// http://normbarnard.com

import UIKit

let size: Int64 = 1_234_567

var fileSize = NSByteCountFormatter.stringFromByteCount(size, countStyle: .File)
print ("file size \(fileSize)")

fileSize = NSByteCountFormatter.stringFromByteCount(size, countStyle: .Binary)

let bigSize: Int64 = 1_234_567_890

fileSize = NSByteCountFormatter.stringFromByteCount(bigSize, countStyle: .File)

fileSize = NSByteCountFormatter.stringFromByteCount(bigSize, countStyle: .Memory)

fileSize = NSByteCountFormatter.stringFromByteCount(bigSize, countStyle: .Binary)

let formatter = NSByteCountFormatter()
formatter.includesActualByteCount = true
formatter.stringFromByteCount(4_678_543)


let formatter2 = NSByteCountFormatter()
formatter2.allowedUnits = [.UseMB, .UseKB]
formatter2.stringFromByteCount(bigSize)

formatter2.stringFromByteCount(5_976)

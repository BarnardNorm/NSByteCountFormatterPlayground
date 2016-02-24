# Displaying Byte Counts using `NSByteCountFormatter`

Let's assume for a moment that you're building an iOS or OSX application that requires
you to display the sizes of some files that your application maintains. For example,
you have an iPhone app that downloads some video and audio files and you need to present
a view to your users that informs them of the sizes of those files so they can choose
which files are using the most space on their iPhone and delete them.

Your first inclination may be to retrieve the attributes of each file that's been
downloaded using `NSFileManager.attributesOfItemAtPath()`, look at the file size
returned in the resulting `Dictionary` and start doing some division by various
powers of two to return the size in gigabytes, megabytes, or kilobytes. I would
suggest that you not do that. The engineers at Apple have already solved this
problem and have provided us all with `NSByteCountFormatter`.

## Using `NSByteCountFormatter`

`NSByteCountFormatter` takes all the drudgery out of calculating byte count sizes and returning them as
standard human readable strings.

For example:

    let size: Int64 = 1_234_567

    NSByteCountFormatter.stringFromByteCount(size, countStyle: .File)
    // returns "1.2 MB"

    let biggerSize: Int64 = 1_234_567_890

    NSByteCountFormatter.stringFromByteCount(biggerSize, countStyle: .File)
    // returns 1.23 GB


From the [Apple docs](https://goo.gl/kXD1wY), there are four different enum values you can specify for `countStyle`:

    - File
    - Memory
    - Decimal
    - Binary

I would use `File` if you're displaying the sizes of a file on the file system, and `Memory` if displaying
internal system RAM memory or some other non-file system representation of byte counts. If for some reason
you don't want to use a power of two value to represent a memory unit (1000 = 1 KB) then you'll want to use
the `Decimal` style in preference to `Binary`. Personally, I'm not sure why you would, but hey, I don't know
your use case.

`NSByteCountFormatter` also provides you with quite a few configuration options to customize your output. Maybe
you want to display the actual byte count along with the human readable value:

    let size: Int64 = 4_678_543

    let formatter = NSByteCountFormatter()
    formatter.includesActualByteCount = true
    formatter.stringFromByteCount(size)
    // returns "4.7 MB (4,678,543 bytes)"

Maybe you need to only show sizes in Megabytes. You can configure an `NSByteCountFormatter` to only
return those units:

    let formatter = NSByteCountFormatter()
    formatter.allowedUnits = .UseMB
    formatter.stringFromByteCount(bigSize)

    //returns "1,234.6 MB"

    formatter.stringFromByteCount(5_976)

    // returns "O MB"  !!

The last example is not very accurate and there doesn't appear to be any way to convince `NSByteCountFormatter` to
show a fractional value in these cases, so you may want to permit display of units smaller than Megabytes.

    formatter.allowedUnits = [.UseMB, .UseKB]
    formatter.stringFromByteCount(5_976)

    // returns "6 KB"


## Conclusion

In addition to the simple examples I've provided here, you can specify more complex formatting options to
`NSByteCountFormatter`. If you need more precise control over formatting your byte counts, read over the
[docs provided by Apple](https://goo.gl/Df1M3Z).

You needn't trouble yourself with performing integer division and string formatting to come up a presentable
way to show your files sizes and byte counts. `NSByteCountFormatter` should be your new friend!

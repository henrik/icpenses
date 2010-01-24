# ICpenses

Parses [ICporter](http://github.com/henrik/icporter)-style JSON files, exported from your bank, and provides expense analysis.

Feel free to write your own ICporter-compatible exporters or analyzers.


## Usage

Provide the file to analyze as a command-line argument.

    ./icpenses.rb ~/Documents/icpenses/data/2010-01_1234-123_456_7.json

Writes some stats to STDOUT.


## Example output

    $ ./icpenses.rb example.json
    == ICpenses

       Account: 1234-567 890 1 (MasterCard)
       Period:  2010-01-01 - 2010-01-31

       By cluster:

     * Groceries                    1300.20  (3)
     * Other                        1000.50  (1)

       By recipient:

     * Someone                      1000.50  (1)
     * ICA                          1000.10  (2)
     * Coop                          300.10  (1)

       By date:

     * 2009-01-01                   1200.60  (2)
     * 2009-01-02                    300.10  (1)
     * 2009-01-04                    800.00  (1)

       All:

     * Someone                      1000.50  2009-01-01
     * ICA                           800.00  2009-01-04
     * Coop                          300.10  2009-01-02
     * ICA                           200.10  2009-01-01

       Total:                       2300.70  (4)


## TODO

This is a rough proof-of-concept. Some things I may do:

 * Add more statistics
 * HTML format with graphs
 * Put cluster definitions in separate files so you can customize and share.
 * Fix multibyte chars messing up the column alignment
 * Tidywork


## Credits and license

By [Henrik Nyh](http://henrik.nyh.se/) under the MIT license:

>  Copyright (c) 2010 Henrik Nyh
>
>  Permission is hereby granted, free of charge, to any person obtaining a copy
>  of this software and associated documentation files (the "Software"), to deal
>  in the Software without restriction, including without limitation the rights
>  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>  copies of the Software, and to permit persons to whom the Software is
>  furnished to do so, subject to the following conditions:
>
>  The above copyright notice and this permission notice shall be included in
>  all copies or substantial portions of the Software.
>
>  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  THE SOFTWARE.

How to construct the crosswalk
================
Tyler Brown
28.06.2023

## Inputs

All inputs are in a folder in the GitHub repository
[`~/input`](https://github.com/tylerjamesbrown7/co_tk/tree/96052d8bcd845533dcea3d6e7d44cb88c3595309/input).

You will need:

-   `isco68_TO_isco88.xlsx`
-   `crosswalk_oficio_isco.xlsx`

## Instructions

1.  [This
    paper](https://repository.urosario.edu.co/server/api/core/bitstreams/d4925f02-0c79-4671-8013-aeba548c854b/content)
    had a workflow for linking ISCO-08 codes to the Colombian CNO-70
    codes.

2.  The CNO-70 codes are based on the ISCO-68 Level 2 classifications.
    (They seem to be identical).
    [Here](http://www.harryganzeboom.nl/isco68/), you will find a
    crosswalk from ISCO-68 to ISCO-88. If you have SPSS, you can open
    the files. I opened it as raw text and edited them manually in
    Excel, which you can find
    [here](https://github.com/tylerjamesbrown7/co_tk/blob/3ea22042ffb42ad474659f7c74390a4b5098a967/input/isco68_TO_isco88.xlsx).

3.  There is a convenient package for converting occupation codes, which
    you can find
    [here](https://guidowe.github.io/occupationcross/index.html). After
    installing this in the R file, you should be able to call
    `reclassify_to_isco08()` on `isco68_TO_isco88`. Two CNO-70 codes,
    `49` and `70`, will not transfer. I subsituted in the first
    occupation in each category, which is not an issue as long as you
    use the Level 2 codes in the final analysis (which matches the
    CNO-70 structure anyway).

4.  Optionally, you can merge this with the ISCO-08 descriptions from
    `crosswalk_oficio_isco.xlsx` in the second sheet. It does not
    populate all codes, but it is helpful for readability.

5.  Finally, you can generate the output `.csv` file. When merging, you
    should use the column `isco08_l2` in order to avoid issues with some
    of the missing occupations. (In the future, I can try to repair the
    broken codes). Since the ISCO structure is hierarchical, there won’t
    be an issue at higher levels. Between versions, some occupations
    were collapsed together or phased out, hence the discrepancy. You
    can also find the Colombian descriptions in the variable
    `cno70_desc` if that is useful.

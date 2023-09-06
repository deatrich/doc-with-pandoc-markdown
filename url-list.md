<!-- -->
# List of URLs mentioned in this guide {#url-list}

If any external URLs are linked in a chapter then they are displayed
and linked below, organized by chapter name.

The shell script which is used to generate this list is named:

generate-url-index.sh
:   This bash program looks for external reference links.

:   The link must occur at the start of a line.

:   The link conforms to Markdown norms for reference links; that is:

```
   [a-phrase-without-whitespace]: https://some.link.somewhere/something
```


Then the script outputs each link by full name, including the digital web
link to itself.  It might be useful in print-only media.



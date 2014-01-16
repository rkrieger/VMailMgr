# VmailMgr

Perl-based management tools and supporting library for manipulating [VMailMgr-style](http://vmailmgr.org/) virtual e-mail domains in Qmail.

## Goals

In short: minimisation of administrator pain for those still administering Qmail/VmailMgr backends.

* Feature-complete for hosting a large cluster of VmaiMgr virtual domains
* Remote control via a job queue
* Correct documentation
* Proper test coverage

## ToDo

At the time of writing, the ToDo list is as follows:

1. Transfer code from existing CVS repository
2. Create .perltidyrc for maintaining uniform style
3. Finish VmailMgr library functions
4. Prepare test suite
5. Import to CPAN

## Contributions

I welcome contributions: as comments and ideas, but as code especially. I prefer to focus on the content of your ideas, rather than their presentation. To keep code consistent, I added the below guidelines. This hopefully allows us to focus on the content, rater than the form, of ideas.

### Style & formatting

Coding styles and tastes differ. To ease keeping things uniformly styled, I've included a [Perltidy](http://perltidy.sourceforge.net/) configuration file with this distribution.

By default, perltidy uses the `.perltidyrc` file in the root of this module. It'd be a great help if you can provide any patches, tests, etc. formatted this way. For example, the following command edits the modified file in place.

```bash
perltidy -b lib/VmailMgr.pm
```

### Patches

Preferably, when providing patches, please send them as unified diffs (`diff -u`). Again, this makes it easier for me to understand things, not because it'd be an 'objectively better' format. 


## Feedback (questions, comments, bugs, requests)

If the code or instructinos do not work for you, please let me know! If you can provide tests or patches with your report, so much the better. Please send these via e-mail to <rkrieger@cpan.org>. I promise to answer all such e-mail, even if a complete response may take a week or so if I'm really swamped with work. E-mail containing code, patches or tests will likely come first. 

I mainly run things off *BSD (notably [OpenBSD](http://www.openbsd.org)) systems, but intend to have code work cleanly on across the board if this can reasonably be done.

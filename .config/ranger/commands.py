# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.
# -----------------------------------------------------------------------------

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


class load_cut_status(Command):
    """:load_cut_status

    Load the cut status from datadir/cut_status
    """

    cut_status_filename = "cut_status"

    def execute(self):
        import sys
        from ast import literal_eval

        fname = self.fm.datapath(self.cut_status_filename)
        unreadable = IOError if sys.version_info[0] < 3 else OSError

        try:
            fobj = open(fname, "r")
        except unreadable:
            return self.fm.notify(
                "Cannot open %s" % (fname or self.cut_status_filename), bad=True
            )
        self.fm.do_cut = literal_eval(fobj.read())
        fobj.close()

        self.fm.ui.redraw_main_column()
        return None

class save_cut_status(Command):
    """:save_cut_status

    Save the cut status to datadir/cut_status
    """

    cut_status_filename = "cut_status"

    def execute(self):
        import sys

        fname = None
        fname = self.fm.datapath(self.cut_status_filename)
        unwritable = IOError if sys.version_info[0] < 3 else OSError
        try:
            fobj = open(fname, "w")
        except unwritable:
            return self.fm.notify(
                "Cannot open %s" % (fname or self.cut_status_filename), bad=True
            )
        fobj.write(str(self.fm.do_cut))

        fobj.close()
        return None

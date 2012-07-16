"""Check and modify puppetd's status

This is currently limited to handling the puppetdlock in /var/lib/puppet/state.
It should arguable check whether puppetd is running by looking at
/var/run/puppet/puppetd.pid and verifying the process exists
"""

import os
import re

LOCKFILE = '/var/lib/puppet/state/puppetdlock'
PID_RE = re.compile('^[0-9]+$')

class PuppetStatusError(StandardError):
    """Exception raised for PuppetStatus errors."""
    pass

class PuppetStatus(object):
    """Check and modify puppetd's status"""
    def __init__(self, lockfile=LOCKFILE):
        self.lockfile = lockfile
        self.pid = None

    def disable(self, reason):
        """Disable puppet, for a given reason."""
        try:
            f = open(self.lockfile, 'w')
            f.write(reason)
            f.close()
        except IOError, e:
            raise PuppetStatusError('Failed to write %s: %s' %
                    (self.lockfile, e.strerror))

    def enable(self):
        """Enable puppet."""
        if os.path.exists(self.lockfile) and not self.running:
            try:
                os.remove(self.lockfile)
            except IOError, e:
                raise PuppetStatusError('Failed to remove %s: %s' %
                        (self.lockfile, e.strerror))

    def __is_disabled(self):
        if os.path.exists(self.lockfile) and not self.running:
            return True
        return False

    def __is_running(self):
        contents = self.__get_contents()
        if PID_RE.match(contents):
            self.pid = contents
            return True
        else:
            self.pid = None
            return False

    def __get_contents(self):
        if os.path.isfile(self.lockfile):
            try:
                return open(self.lockfile).read().strip()
            except:
                pass
        return ''

    def __get_reason(self):
        if self.disabled:
            return self.__get_contents()

    disabled = property(__is_disabled)
    reason = property(__get_reason)
    running = property(__is_running)

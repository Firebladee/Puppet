#!/usr/bin/python -tt
# Copyright tmz, Source: http://people.fedoraproject.org/~tmz/scripts/puppetstatus
# Check and modify puppetd's status

import os
import sys
import optparse
import puppetstatus

def get_status(s):
    if s.running:
        status = 'Puppet is running (pid %s).' % s.pid
    elif not s.disabled:
        status = 'Puppet is not disabled'
    else:
        if s.reason:
            status = 'Puppet is disabled: %s' % s.reason
        else:
            status = 'Puppet is disabled, but no reason was given.'
    return status

def enable(s):
    if s.running:
        print 'Puppet is running (pid %s), not removing lockfile.' % s.pid
    elif not s.disabled:
        print 'Puppet is not disabled.'
    else:
        try:
            s.enable()
            print 'Removed lockfile (%s)' % s.lockfile
        except puppetstatus.PuppetStatusError, e:
            print e
            return 1
    return 0

def disable(s, reason, force=False):
    if s.running:
        print 'Puppet is currently running (pid %s)' % s.pid
        return 1
    elif s.disabled and not force:
        print 'Puppet is already disabled for the following reason:'
        print '%s\n' % s.reason
        print 'Use --force (-f) to overwrite.'
        return 1

    # Looks good, disable
    try:
        s.disable(reason)
        print 'Disabled puppet with reason:\n%s' % reason
    except puppetstatus.PuppetStatusError, e:
        print e
        return 1
    return 0

def main():
    usage = 'sudo %prog [-d <reason for disabling> | -e | -s]'
    parser = optparse.OptionParser(usage=usage, description=__doc__)
    parser.add_option('-d', '--disable', action='store_true',
                      help='Disable puppet (this is the default action)')
    parser.add_option('-e', '--enable', action='store_true',
                      help='Re-enable puppet (removes the lockfile)')
    parser.add_option('-f', '--force', action='store_true',
                      help='Overwrite an existing lockfile')
    parser.add_option('--lockfile', metavar='path',
                      default=puppetstatus.LOCKFILE,
                      help='Lockfile to use [%default]')
    parser.add_option('-s', '--status', action='store_true',
                      help='Check if lockfile exists and print reason')
    opts, args = parser.parse_args()

    # Some basic sanity checks.
    if opts.disable:
        try:
            user = os.environ['SUDO_USER']
        except KeyError:
            parser.error('You must run this script via sudo.')

    # This prevents someone from just setting SUDO_USER, though someone could
    # still run as root and set SUDO_USER=normal_user.  But there's only so
    # many ways to shield against foolishness.
    if (opts.disable or opts.enable) and not os.geteuid() == 0:
        parser.error('Root privileges are required to enable or disable puppet.')

    # We'd prefer it if folks didn't just run sudo as root to appease us.
    if opts.disable:
        if user == 'root':
            print "You're doing it wrong.  Run sudo from a normal user account."
            sys.exit(1)

    # Get a PuppetStatus instance
    s = puppetstatus.PuppetStatus(opts.lockfile)

    # Show current status
    if opts.status:
        print get_status(s)
        return 1

    # Enable puppet
    if opts.enable:
        return enable(s)

    # Disable puppet, with cause
    if opts.disable:
        if len(args) != 1:
            parser.print_usage()
            return 1

        reason = args[0]

        minlen, maxlen = 8, 80
        if len(reason) not in range(minlen, maxlen):
            parser.error('Reason must be between %s and %s characters' %
                    (minlen, maxlen))
        elif puppetstatus.PID_RE.match(reason):
            print "You're joking, right?"
            return 1

        reason = '%s (%s)' % (reason, user)

        return disable(s, reason)

    # If we get here, just give usage info
    parser.print_usage()
    return 1

if __name__ == '__main__':
    ret = main()
    sys.exit(ret)

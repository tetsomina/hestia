#!/usr/bin/python

# Must edit /usr/lib/pythonX.YY/site-packages/khal/settings/khal.spec
# and add 'muspelheim' to theme options. Additionally, will want to
# copy and paste the below code to /usr/lib/pythonX.YY/site-packages/khal/ui/colors.py
# at the bottom of the file

muspelheim = [
    ('header', 'white', 'black'),
    ('footer', 'white', 'black'),
    ('line header', 'black', 'white', 'bold'),
    ('bright', 'dark blue', 'white', ('bold', 'standout')),
    ('list', 'black', 'white'),
    ('list focused', 'white', 'light blue', 'bold'),
    ('edit', 'black', 'white'),
    ('edit focused', 'white', 'light blue', 'bold'),
    ('button', 'black', 'dark cyan'),
    ('button focused', 'white', 'light blue', 'bold'),

    ('reveal focus', 'black', 'light gray'),
    ('today focus', 'white', 'dark red'),
    ('today', 'dark gray', 'dark green',),

    ('date header', 'light gray', 'black'),
    ('date header focused', 'black', 'white'),
    ('date header selected', 'dark gray', 'light gray'),

    ('dayname', 'light gray', ''),
    ('monthname', 'light gray', ''),
    ('weeknumber_right', 'light gray', ''),
    ('edit', 'white', 'dark blue'),
    ('alert', 'white', 'dark red'),
    ('mark', 'white', 'dark green'),
    ('frame', 'white', 'black'),
    ('frame focus', 'light red', 'black'),
    ('frame focus color', 'dark blue', 'black'),
    ('frame focus top', 'dark red', 'black'),

    ('editbx', 'light gray', 'dark blue'),
    ('editcp', 'black', 'light gray', 'standout'),
    ('popupbg', 'white', 'black', 'bold'),
]

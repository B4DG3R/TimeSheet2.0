# TimeSheet2.0
Time Sheet is an iOS app built to do my work time sheet on.  The app allows you add jobs one at a time to a list, save each the job, and then export the job list in csv format via email.  You can then clear the list at the end of the week and start a fresh time sheet.

## Motivation
This app was built to basically solve the problem of me doing a paper time sheet at work.  I didn't want to keep filling out my time sheet on paper, so i built an app to do it on my phone.  So no more paper, and it makes my time sheet more accurate as i fill it in as soon as ive finished a job.   This is version 2.0 of the App.  Better more user friendly UI.

## Build status
This is version 2.0 of the project.  It's ready for day to day testing as of the 17/08/2020.

## Code style
It partially conforms to MVC.  As I refactor it will more and more  but for now i just wanted to get an MVP.

## Screenshots
Screen shot to come...

## Tech/framework used
<b>Built with</b>
Xcode Version 11.5 (11E608c)

## Features
Features of the App:

- Add jobs individually.
- Hours for current day are shown on the main page.
- Jobs are then added to a list in date order.
- You can view the jobs for each day in a list.
- App data is saved after each job is added.
- Can export all app data in CSV format via email
- Add email address to app and it will save to user defaults even when app is closed.
- Cleat Data button in settings will clear all time sheet data.

Not currently working:

- Everything that is in the App works.

## Installation
Must have Xcode Version 12.0 beta installed
App only works on iOS 13.4 and later.

## Tests
No tests currently.

## How to use?
- Open the App and it will load onto the main page.
- Your logged hours for that day will show on the main page.
- Select the plus symbol at the bottom to add a job.
- Select a Job code via UI Picker.
- Job description box is the automatically populated with the Job Description.
- Add machine number (Y Number)
- Add hours to Hours box.  Hours must be an integer or double e.g. 1, 1.0, 1.2, 1.5, 2.5.
- Click plus symbol to add the job to the current jobs list.
- Jobs are then saved in a list in date order, each job on a new line for export.
- Jobs are also saved in a list for each day so that they can be viewed in a tableView.
- Add email address to app via settings and it will save to user defaults even when app is closed.
- Time sheet data will save to user defaults even when app is closed.
- App data can be exported in CSV format via email by clicking the export button on main page.
- Clear Data button in settings will clear all time sheet data, ready to start a new week.

## Issues
As far as I am aware there are no known issues.

## Future Features
- Ability to edit saved Jobs
- I would like to add some colour to the UI.
- I would like to add a bar graph of some description to the main UI to show the hours for each day.

## Contribute
Any contributions, advice of suggestions welcome.

## Credits
Credits: Matt Hollyhead

## License
A short snippet describing the license (MIT, Apache etc)

MIT © [Matt Hollyhead]()

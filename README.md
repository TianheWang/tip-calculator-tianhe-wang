# Pre-work - *Tippy*

**Tippy** is a tip calculator application for iOS.

Submitted by: **Tianhe Wang**

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations on tips and total
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Customized app icon
- [x] Customized background image
- [x] Bill split with a stepper input
- [x] Add preference on pre-tax tipping or after-tax tipping

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/RNCL2Ef.gif?1' title='Video Walkthrough' width='' alt='Video Walkthrough' />

With Tax Preference:

<img src='http://i.imgur.com/EddFlvr.gif?1' title='With Tax Preference' width='' alt='With Tax Preference' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Challenges:
1. Getting the background image in place
2. Making the number format right, with currency thousands separators
3. App icon: attempting a few times until I noticed that a 80x80 size is required, instead recommended
4. Remembering bill amount: it took me a few attempts to get both timestamp and bill amount value stored

## License

    Copyright [2016] [Tianhe Wang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

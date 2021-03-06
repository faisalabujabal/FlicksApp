# Project 1 - Flicks App

Flicks App is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 8 hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [ ] Movies are displayed using a CollectionView instead of a TableView.
- [ ] User can search for a movie.
- [x] All images fade in as they are loading.
- [ ] Customize the UI.

The following **additional** features are implemented:

- [x] added more data to each cell

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I had a hard time to excute a function upon success of the retrival of the data

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/rLOdHdU.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The hardest part was to excute the function to reload the table view upon success of the networking request
Notes: My app is not slow I delayed the time of the funciton to display the animations

## License

    Copyright 2016 Faisal Abu Jabal

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
    
    
    
    
# Project 2 - Flicks App

Flicks App is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 2 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view movie details by tapping on a cell.
- [x] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [x] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [x] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [x] the title of the tab bar view controllers change programmatically depending on what endpoint I am using
- [x] implemented two extra endpoints (upcoming and popular)
- [x] added a scroll view for the movie detail page
- [x] add a network error message from last week
- [x] images fade in if they are loaded from the network from last week
- [x] added an edge swipe gesture to return from the details viewer to the table view

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/STLB7P6.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://i.imgur.com/vIE8wxZ.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The hardest part was coming up with ideas to add to the app, and learning about Closures so I can do actions on success and on fail of the retrival of the data from the movie database API.

Sources of the icons:
thenounproject.com
Thanks to: Daouna Jeong, Studio Fibonacci, Xavier Girones, and Calvin Goodman

## License

    Copyright 2016 Faisal Abu Jabal

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

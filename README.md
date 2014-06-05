FlashSkyBlog
============

Simple Blog 

2014-4-27
mainly bulid two visual templates with HTML and CSS.
"index.html" is the homepage of the blog.
"article.html" is the page of a certain article including comments.

2014-5-3
1. improve index page by adding category side bar and navigation bar.
2. add "photo gallery" and "new post" pages with HTML,CSS and Javascript:
  "article_post.html" is the page to post a new article, mainly take use of "markitup" plugin(with JQuery).
  "photo_gallery.html" is the page to view snap shot of different photos.
  "photo_view.html" is the page to view photos by sequence and corresponding comments.(modification is necessary when integrate with Ruby on rails)
  
2014-5-10
1. create ruby on rails project of the blog.
2. implement comment post and basic form validation.
3. move previous css/js/jpg/html files to "design" folder for future use, and copy some files to  corresponding sub-folders in "app/asset".

2014-5-16
1. create "post" action in blog_controller and corresponding html/css , integrate "markitup " text editor to implement post a new article.
2. create "gallery" and "album" action in blog_controller and corresponding html/css , now blog can upload picture,  view snap shot and view pictures by sequence in album when click a certain picture. 
 
2014-5-23
1. show published(created) time of articles.
2. add login and register related function. add sessions_controller and users_controller.Users can register repective blogs and view others's page through url(/blog/:name/...).

2014-5-31
1. add "tag" property and "category" property for articles, and corresponding edit/search function.
2. logged in user can edit or delete its articles and delete comments.
3. validate archive list , category list,recent articles list and recent comments list at blog index page.
4. change the form of post comment: before submit comment , user should log in.
5. guest can browse interested blog list at login page.

2014-6-5
1. add comments board for album(pictures) and message board for blog.
2. can edit and delete picture , can add description for a picture.
3. when forgetting his password, user can reset the password by clicking link sent to his registered email.
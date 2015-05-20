# Basic information about your site
title = "Your Name's Research Site"
description = "This is a site for my research project on blah blah blah"
author = "Your Name"
email = "yname@someuniversity.edu"
url = "http://someuniversity.edu/~yname/my-awesome-research-site"
css = [
	"styles/main.css"
]

# People involved in your project
people =
	alice: "Alice Aliceson"
	bob: "Bob Roberts"
	eve: "Eve Evil"
# You can add these people to meeting metadata so you can remember who
# participated in the meeting. See the sample meeting for an example.


# If you want to enable comments on your site, uncomment this line,
# change this to the name of your disqus name:
# disqus = "mysitename"
disqus = false
# Note: disqus will only show up when the site is live, not while running
# the development server

###################################################
#                                                 #
#  You don't need to modify anything below here!  #
#                                                 #
###################################################

docpadConfig = {
	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	templateData:
		site:
			# The default title of our website
			title: title

			# The website description (for SEO)
			description: description

			# The website keywords (for SEO) separated by commas
			keywords: "nope"

			# The website author's name
			author: author

			# The website author's email
			email: email

			# Styles
			styles: [
				"//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/css/bootstrap.min.css",
				"//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/css/bootstrap-theme.min.css"
			]

			localStyles: css

			# Scripts included with each page
			scripts: [
				"//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js",
				"//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.4/underscore-min.js",
				"//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js",
				"//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/js/bootstrap.min.js",
			]

			services:
				disqus: disqus



		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')

		prettyDate: (date) ->
			"#{date.getMonth() + 1}/#{date.getDate()}/#{date.getFullYear()}"

		getUrl: (document) ->
			@site.url + (document.url or document.get?('url'))

		# audioLink: (text, url) ->
		# 	"""
		# 	<ul class="playlist">
		# 	<li>[#{text}](../audio/#{url})</li>
		# 	</ul>
		# 	"""

		people: people


	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		pages: (database) ->
			database.findAllLive({
				pageOrder: $exists: true
				ignored: $ne: true
			}, [pageOrder:1,title:1]).on "add", (page) ->
				page.setMeta(
					layout: "page"
				)

		posts: (database) ->
			database.findAllLive({
				relativeOutDirPath: $startsWith: 'posts'
				ignored: $ne: true
			}, [date:-1]).on "add", (post) ->
				post.setMeta
					layout: "post"

		meetings: (database) ->
			database.findAllLive({
				relativeOutDirPath: $startsWith: 'meetings'
				ignored: $ne: true
			}, [date:-1]).on "add", (meeting) ->
				meeting.setMeta(
					layout: "meeting"
				)

	environments:
		deploy:
			templateData:
				site:
					url: url

		development:
			templateData:
				site:
					url: "http://localhost:9778"
					services:
						disqus: false

	plugins:
		markedOptions:
			tables: true
}

# Export our DocPad Configuration
module.exports = docpadConfig
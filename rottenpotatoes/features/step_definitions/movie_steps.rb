# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    
    # puts movie[:title]
    # puts movie[:rating]
    # puts movie[:release_date]
    Movie.create!(title: movie[:title], rating: movie[:rating], release_date: movie[:release_date]) 
    
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  body = page.body
  all_matches = body.scan(/(#{e1}|#{e2})/)
  right_matches = [[e1],[e1],[e2],[e2]]
  all_matches.should eq right_matches
 

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(', ')
  if uncheck
    ratings.each do |rating|
      steps %{
        When I uncheck "ratings_#{rating}"
      }
    end    
  else
    ratings.each do |rating|
      steps %{
        When I check "ratings_#{rating}"
      }
    end
  end 
 
  # fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  page.should have_css("table#movies tr", :count=>11)
end

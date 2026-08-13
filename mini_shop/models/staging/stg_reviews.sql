SELECT 
    reviewer_name, 
    review_time, 
    star_rating, 
    headline, 
    review_content, 
    experience_time
FROM {{ ref('walmart_trustpilot_reviews')}}
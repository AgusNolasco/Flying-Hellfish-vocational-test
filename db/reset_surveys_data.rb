### Delete existing responses and surveys ###
Response.all.map { |r| r.destroy }
Survey.all.map   { |s| s.destroy }

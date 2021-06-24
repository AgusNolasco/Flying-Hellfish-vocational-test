### Delete existing dataset ###
Response.all.map { |r| r.destroy }
Survey.all.map   { |s| s.destroy }
Outcome.all.map  { |o| o.destroy }
Career.all.map   { |c| c.destroy }
Choice.all.map   { |c| c.destroy }
Question.all.map { |q| q.destroy }

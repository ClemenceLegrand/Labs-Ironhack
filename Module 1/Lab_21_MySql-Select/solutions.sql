use publications;
-- challenge 1
select a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name
from authors a 
inner join titleauthor ta
on a.au_id = ta.au_id
inner join titles t 
on t.title_id = ta.title_id
inner join publishers p 
on t.pub_id = p.pub_id;

-- Challenge 2
select a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name, count(ta.title_id)
from authors a 
inner join titleauthor ta
on a.au_id = ta.au_id
inner join titles t 
on t.title_id = ta.title_id
inner join publishers p 
on t.pub_id = p.pub_id
group by a.au_id,p.pub_name;

-- Challenge 3
SELECT a.au_id, a.au_lname, a.au_fname, sum(s.qty) as TOTAL
from authors a
inner join titleauthor ta
on a.au_id= ta.au_id
inner join sales s
on ta.title_id = s.title_id
group by a.au_id
order by TOTAL DESC
limit 3;

-- Challenge 4
SELECT a.au_id, a.au_lname, a.au_fname, ifnull(sum(s.qty),0) as TOTAL
from authors a
left join titleauthor ta
on a.au_id= ta.au_id
left join sales s
on ta.title_id = s.title_id
group by a.au_id
order by TOTAL DESC
limit 23;

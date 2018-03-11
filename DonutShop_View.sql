drop view MyView
CREATE VIEW MyView
AS
	SELECT top 2 a.BoxID,
		(select sum(d.Price)
		from DonutsBoxes db
		inner join Donuts d on d.DonutID = db.DonutID
		where db.BoxID = a.BoxID) as Price
	from Aquisitions a
	inner join Clients c on c.ClientID = a.ClientID
	where c.Address not like '%Cluj%'
	Order by Price desc


select * from MyView
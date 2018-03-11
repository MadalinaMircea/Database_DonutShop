alter FUNCTION MyFunc(
	@Box VARCHAR(10)
)
RETURNS BIT
AS BEGIN
	declare @res bit
	declare @aux int
	declare @BoxID int
	if isnumeric(@Box) = 1
	begin
		set @BoxID = convert(int, @Box)

		select @aux = count(*)
		from Boxes b
		where b.BoxID = @BoxID

		if @aux = 0
			set @res = 0
		else
		begin
			select @aux = count(*)
			from Donuts d
			inner join
				(select d.DonutID as DonutID, count(d.DonutID) as Quantity
				from Donuts d
				inner join DonutsBoxes db on d.DonutID = db.DonutID
				where db.BoxID = 1
				group by d.DonutID) d2 on d.DonutID = d2.DonutID
			where d.Stock < d2.Quantity

			if @aux = 0
				set @res = 1
			else
				set @res = 0
		end
	end
	else
		set @res = 0
	return @res
end

print dbo.MyFunc(1)
ALTER PROCEDURE Buy
	@Client VARCHAR(5),
	@Opt VARCHAR(10),
	@Donut VARCHAR(5),
	@Box VARCHAR(5)
AS
BEGIN
	declare @aqid int
	declare @BoxID INT
	declare @dbID int
	declare @DonutID int
	declare @aux int
	if isnumeric(@Client) = 0
	begin
		--client id is incorrect
		PRINT 'Invalid client ID'
	end
	else
	begin
		--client id is correct
		declare @ClientID INT
		set @ClientID = convert(INT, @Client)

		if	@Donut IS NULL
		begin
			--donutId is NULL so they either buy a box or the data is incorrect
			if @Box IS NULL
			begin
				--both ID's are NULL, so incorrect data
				PRINT 'Invalid input, both IDs null'
			end
			else
			begin
				if isnumeric(@Box) = 0
				begin
					--id is not int
					PRINT 'Invalid input, Box ID not number'
				end
				else
				begin

					if @Opt != 'Online' and @Opt != 'Shop'
					begin
						--invalid Option
						PRINT 'Invalid input, option not Online or Shop'
					end
					else
					begin

						--buying a box online

						set @BoxId = convert(INT, @Box)
						select @aux = count(*) from Boxes where BoxID = @BoxID
						if @aux = 0
						begin
							PRINT 'Box does not exist'
						end
						else begin
			
							--check if the client exists, if not, add
							select @aux = count(*) from Clients where ClientID = @ClientID
							if @aux = 0
							begin
								insert into Clients values (@ClientID, 'Client ' + convert(varchar(5), @ClientID), 'TBA', 'TBA')
							end

							--AqID will be 1 if the table is empty of max(AqID)+1 is the table is not empty
							select @aqid = count(*) from Aquisitions
							if @aqid = 0
							begin
								set @aqid = 1
							end
							else
							begin
								select @aqid = max(AqID) from Aquisitions
								set @aqid = @aqid + 1
							end

							insert into Aquisitions values (@aqid, @ClientID, @BoxID, @Opt)

							declare @id int
							declare db_cursor cursor for
								select DonutID
								from DonutsBoxes db
								where db.BoxID = @BoxID

							open db_cursor
							fetch next from db_cursor into @id
							while @@FETCH_STATUS = 0
							begin
								update Donuts set Stock = Stock - 1 where DonutID = @id
								fetch next from db_cursor into @id
							end
							close db_cursor
							deallocate db_cursor

							PRINT 'Box aquisition registered'
						end
					end
				end
			end
		end
		else
		begin
			if ISNUMERIC(@Donut) = 0
			begin
				--invalid ID
				PRINT 'Invalid input, donut ID not number'
			end
			else
			begin
				--data is correct, they are buying an individual donut

				set @DonutID = convert(int, @Donut)
				select @aux = count(*) from Donuts where DonutID = @DonutID
				if @aux = 0
				begin
					PRINT 'Donut does not exist'
				end
				else
				begin

					if @Opt = 'Online'
					begin
						print 'Cannot buy individual donut online'
					end
					else
					begin
					
						--check if the client exists, if not, add
						select @aux = count(*) from Clients where ClientID = @ClientID
						if @aux = 0
						begin
							insert into Clients values (@ClientID, 'Client ' + convert(varchar(5), @ClientID), 'TBA', 'TBA')
						end

						--create a Box with that donut, the BoxID will be either 1 if the table is empty or max(BoxID)+1 if it is not
						select @BoxID = count(*) from Boxes
						if @BoxID = 0
						begin
							set @BoxID = 1
						end
						else
						begin
							select @BoxID = max(BoxID) from Boxes
							set @BoxID = @BoxID + 1
						end

						insert into Boxes values (@BoxID, 'Box ' + convert(varchar(5), @BoxID))

						--add the Donut to the new Box, dbID will be either 1 if the table is empty or max(dbID)+1 if it is not
						select @dbID = count(*) from DonutsBoxes
						if @dbID = 0
						begin
							set @dbID = 1
						end
						else
						begin
							select @dbID = max(dbID) from DonutsBoxes
							set @dbID = @dbID + 1
						end

						insert into DonutsBoxes values (@dbID, @BoxID, @DonutID)

						--register the aquisition, AqID will be 1 if the table is empty of max(AqID)+1 is the table is not empty
						select @aqid = count(*) from Aquisitions
						if @aqid = 0
						begin
							set @aqid = 1
						end
						else
						begin
							select @aqid = max(AqID) from Aquisitions
							set @aqid = @aqid + 1
						end

						insert into Aquisitions Values(@aqid, @ClientID, @BoxID, @Opt)

						update Donuts set Stock = Stock - 1 where DonutID = @DonutID
						PRINT 'Donut aquisition registered'
					end
				end
			end
		end
	end
END

exec dbo.Buy 3, 'Shop', NULL, 1

select * from Clients
select * from Donuts
select * from Boxes
select * from DonutsBoxes
select * from Aquisitions

delete from Aquisitions
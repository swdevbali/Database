USE [FikrPos]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 04/12/2013 08:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Price] [float] NOT NULL,
	[Unit] [varchar](50) NOT NULL,
	[Discount] [float] NOT NULL,
	[Tax] [float] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Product] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AppUser]    Script Date: 04/12/2013 08:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](255) NULL,
	[Role] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AppUser] ON [dbo].[AppUser] 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppInfo]    Script Date: 04/12/2013 08:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsInit] [tinyint] NOT NULL,
	[Company Name] [varchar](255) NULL,
	[Company Address] [varchar](255) NULL,
	[Branch Code] [varchar](20) NULL,
 CONSTRAINT [PK_AppInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 04/12/2013 08:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[UserId] [int] NOT NULL,
	[Total Quantity] [int] NULL,
	[Total Discount] [float] NULL,
	[Total Tax] [float] NULL,
	[Total Price] [float] NULL,
	[Total Extended Price] [float] NULL,
	[Payment] [float] NULL,
	[Change] [float] NULL,
 CONSTRAINT [PK_PosSalesTransaction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleDetail]    Script Date: 04/12/2013 08:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Qty] [int] NOT NULL,
	[Tax] [float] NOT NULL,
	[Discount] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[Extended Price] [float] NULL,
	[SaleID] [int] NOT NULL,
 CONSTRAINT [PK_SaleDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 04/12/2013 08:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inventory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Current Quantity] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[SaleDetailID] [int] NULL,
	[Minimum Stock] [int] NULL,
	[Message] [varchar](255) NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventoryDetail]    Script Date: 04/12/2013 08:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventoryDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[SaleDetailID] [int] NULL,
	[Change] [int] NOT NULL,
	[Message] [varchar](255) NULL,
	[Current Stock] [int] NULL,
 CONSTRAINT [PK_InventoryDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[InsertSaleDetail]    Script Date: 04/12/2013 08:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertSaleDetail]
	@SaleDetailID int output,
    @ProductID int,
    @Qty int,
	@Tax float,
	@Discount float,
	@Price float,
	@SaleID int
AS
BEGIN
	declare @InventoryCurrentQuantity int;
	declare @InventoryNextQuantity int;
	declare @ProductName varchar(255);
    declare @msg varchar(255);	
	declare @InventoryID int;

    begin try 
		begin transaction
        --Update SaleDetail
        INSERT INTO dbo.SaleDetail(ProductID, Qty, Tax, Discount, Price, [Extended Price], SaleID)
        VALUES (@ProductID, @Qty, @Tax, @Discount, @Price, @Price+@Tax-@Discount,@SaleID);
		set @SaleDetailID = CAST (SCOPE_IDENTITY() as Int);

        --Update Inventory here		
		SELECT @InventoryCurrentQuantity = [Current Quantity]
		FROM Inventory 
		WHERE ProductID = @ProductID;

		set @InventoryNextQuantity = @InventoryCurrentQuantity - @Qty;

		if @InventoryNextQuantity >= 0
			begin

				-- this should insert a history of inventory
				UPDATE dbo.Inventory
				SET [Current Quantity] = @InventoryNextQuantity,
				Message='POS Sale',
				Date = GETDATE()
				WHERE ProductID = @ProductID;

				SELECT @InventoryID = ID
				FROM Inventory 
				WHERE ProductID = @ProductID;
								
				insert into dbo.InventoryDetail(InventoryID, SaleDetailID, Date, Change, Message, [Current Stock]) 
				values(@InventoryID, @SaleDetailID, GETDATE(), -@Qty,'POS Sale', @InventoryNextQuantity);

			end 
		else		
			begin
				RAISERROR ('Stock will become negative',
				   16, -- Severity.
				   1 -- State.
				   );
			end
			SET @SaleDetailID = CAST (SCOPE_IDENTITY() as Int)
        commit transaction;
    end try
    begin catch
		rollback transaction 
		SELECT @ProductName = [Name]
		FROM Product 
		WHERE ID = @ProductID;
		
		set @msg = 'Stock of product "'+Convert(varchar(255),@ProductName) +'" will become negative';
		RAISERROR (@msg,
				   16, -- Severity.
				   1 -- State.
				   );
        
    end catch
END
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 04/12/2013 08:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProduct]
    @Code varchar(255), 
	@Name varchar(255), 
	@Price float, 
	@Unit varchar(255), 
	@Discount float, 
	@Tax float, 
	@Stock int,
	@MinimumStock int
AS
BEGIN

	declare @ProductID int;
	declare @InventoryID int;

	begin transaction my_tran
	begin try 
		insert into dbo.product(Code, [Name], Price, Unit, Discount, Tax)
		values(@Code, 
		@Name, 
		@Price, 
		@Unit, 
		@Discount, 
		@Tax);

		set @ProductID = SCOPE_IDENTITY();

		insert into dbo.Inventory(ProductID,[Current Quantity], [Date],[Minimum Stock],Message) 
		values (@ProductID, @Stock, GETDATE(),@MinimumStock,'Initial stock');

		SET @InventoryID = CAST (SCOPE_IDENTITY() as Int)
		insert into dbo.InventoryDetail(InventoryID, Date, Change, Message, [Current Stock]) 
		values(@InventoryID, GETDATE(), @Stock,'Initial stock', @Stock);

		commit transaction;
	end try
    begin catch
        rollback transaction
		RAISERROR ('Error inserting product. Existing product code',
				   16, -- Severity.
				   1 -- State.
				   );
    end catch
END
GO
/****** Object:  Default [DF_Users_isadmin]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF_Users_isadmin]  DEFAULT ((0)) FOR [Role]
GO
/****** Object:  Default [DF_SaleDetail_Extended Prce]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[SaleDetail] ADD  CONSTRAINT [DF_SaleDetail_Extended Prce]  DEFAULT ((0)) FOR [Extended Price]
GO
/****** Object:  ForeignKey [FK_PosSalesTransaction_AppUser]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_PosSalesTransaction_AppUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_PosSalesTransaction_AppUser]
GO
/****** Object:  ForeignKey [FK_SaleDetail_Product]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[SaleDetail]  WITH CHECK ADD  CONSTRAINT [FK_SaleDetail_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SaleDetail] CHECK CONSTRAINT [FK_SaleDetail_Product]
GO
/****** Object:  ForeignKey [FK_SaleDetail_Sale]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[SaleDetail]  WITH CHECK ADD  CONSTRAINT [FK_SaleDetail_Sale] FOREIGN KEY([SaleID])
REFERENCES [dbo].[Sale] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SaleDetail] CHECK CONSTRAINT [FK_SaleDetail_Sale]
GO
/****** Object:  ForeignKey [FK_Inventory_Product]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Product]
GO
/****** Object:  ForeignKey [FK_Inventory_SaleDetail]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_SaleDetail] FOREIGN KEY([SaleDetailID])
REFERENCES [dbo].[SaleDetail] ([ID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_SaleDetail]
GO
/****** Object:  ForeignKey [FK_InventoryDetails_InventoryDetails]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[InventoryDetail]  WITH CHECK ADD  CONSTRAINT [FK_InventoryDetails_InventoryDetails] FOREIGN KEY([InventoryID])
REFERENCES [dbo].[Inventory] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InventoryDetail] CHECK CONSTRAINT [FK_InventoryDetails_InventoryDetails]
GO
/****** Object:  ForeignKey [FK_InventoryDetails_SaleDetail]    Script Date: 04/12/2013 08:10:29 ******/
ALTER TABLE [dbo].[InventoryDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_InventoryDetails_SaleDetail] FOREIGN KEY([SaleDetailID])
REFERENCES [dbo].[SaleDetail] ([ID])
GO
ALTER TABLE [dbo].[InventoryDetail] NOCHECK CONSTRAINT [FK_InventoryDetails_SaleDetail]
GO

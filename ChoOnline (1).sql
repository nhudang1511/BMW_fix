USE [ChoOnline]
GO
/****** Object:  Table [dbo].[_Order]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Order](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[storeId] [int] NULL,
	[deliveryId] [int] NULL,
	[commissionId] [int] NULL,
	[address] [nvarchar](255) NOT NULL,
	[phone] [int] NOT NULL,
	[status] [nvarchar](255) NOT NULL,
	[isPaidBefore] [bit] NULL,
	[amountFromUser] [int] NOT NULL,
	[amountFromStore] [int] NOT NULL,
	[amountToStore] [int] NOT NULL,
	[amountToGD] [int] NOT NULL,
	[createdAt] [date] NULL,
	[updatedAT] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_User]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_User](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[firstname] [nvarchar](32) NOT NULL,
	[lastname] [nvarchar](32) NOT NULL,
	[slug] [nvarchar](100) NULL,
	[id_card] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](20) NULL,
	[isEmalActive] [bit] NULL,
	[isPhoneActive] [bit] NULL,
	[salt] [varchar](max) NULL,
	[hashed_password] [varchar](max) NOT NULL,
	[_role] [varchar](10) NULL,
	[addresses] [nvarchar](200) NULL,
	[avatar] [nvarchar](500) NULL,
	[cover] [nvarchar](500) NULL,
	[point] [int] NULL,
	[e_wallet] [decimal](10, 4) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[DonHang]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[DonHang] as
select o._id, u.lastname, u.firstname, o.status
from _Order as o, _User as u
where o.userId = u._id
GO
/****** Object:  Table [dbo].[ListImagesProduct]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListImagesProduct](
	[_id] [int] NOT NULL,
	[image] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NULL,
	[productId] [int] NULL,
	[count_SP] [int] NULL,
	[createdAt] [date] NULL,
	[updatedAT] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[slug] [nvarchar](110) NULL,
	[description] [nvarchar](1000) NOT NULL,
	[price] [decimal](18, 0) NOT NULL,
	[promotionalPrice] [decimal](18, 0) NOT NULL,
	[quantity] [int] NOT NULL,
	[sold] [int] NOT NULL,
	[isActive] [bit] NULL,
	[isSelling] [bit] NULL,
	[categoryId] [int] NULL,
	[storeId] [int] NULL,
	[isDeleted] [bit] NULL,
	[rating] [int] NULL,
	[createdAt] [date] NULL,
	[updatedAt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderDetail]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[OrderDetail] as
select oi._id, oi.orderId, oi.productId, oi.count_SP, p.name, p.quantity, li.image
from OrderItem as oi, Product as p, ListImagesProduct as li
where oi.productId = p._id and p._id = li._id
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](1000) NOT NULL,
	[price] [decimal](18, 0) NOT NULL,
	[isDeleted] [bit] NULL,
	[createdAt] [date] NULL,
	[updatedAt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ThongtinOrder]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongtinOrder] as
select o._id, d.lastname, d.firstname, o.address, o.phone, dv.name, dv.price, o.amountFromUser, o.isPaidBefore, o.createdAt, o.status
from _Order as o, DonHang as d, Delivery as dv
where o._id = d._id and o.deliveryId = dv._id
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[storetId] [int] NULL,
	[createdAt] [date] NULL,
	[updatedAT] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItem]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItem](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[cartId] [int] NULL,
	[productId] [int] NULL,
	[count_SP] [int] NOT NULL,
	[createdAt] [date] NULL,
	[updatedAT] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[_name] [nvarchar](32) NOT NULL,
	[slug] [nvarchar](100) NULL,
	[categoryId] [int] NULL,
	[_image] [nvarchar](500) NULL,
	[isDeleted] [bit] NULL,
	[createdAt] [date] NULL,
	[updatedAt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Commission]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Commission](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[_name] [nvarchar](32) NOT NULL,
	[cost] [decimal](10, 4) NOT NULL,
	[_description] [nvarchar](3000) NOT NULL,
	[isDeleted] [bit] NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListImagesStore]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListImagesStore](
	[_id] [int] NULL,
	[featured_image] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Style]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Style](
	[StyleId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StyleId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[_name] [nvarchar](100) NOT NULL,
	[bio] [nvarchar](1000) NOT NULL,
	[slug] [nvarchar](100) NULL,
	[ownerId] [int] NULL,
	[isActive] [bit] NULL,
	[isOpen] [bit] NULL,
	[avatar] [nvarchar](500) NULL,
	[cover] [nvarchar](500) NULL,
	[featured_images] [nvarchar](500) NULL,
	[commissionId] [int] NULL,
	[point] [int] NULL,
	[rating] [int] NULL,
	[e_wallet] [decimal](10, 4) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store_Staff]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store_Staff](
	[storeId] [int] NOT NULL,
	[staffId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[storeId] ASC,
	[staffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Style]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Style](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](32) NOT NULL,
	[image] [nvarchar](100) NULL,
	[isDeleted] [bit] NULL,
	[createdAt] [date] NULL,
	[updatedAt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Style_Category]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Style_Category](
	[StyleId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StyleId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StyleValue]    Script Date: 12/18/2022 7:46:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StyleValue](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](32) NOT NULL,
	[styleId] [int] NULL,
	[isDeleted] [bit] NULL,
	[createdAt] [date] NULL,
	[updatedAt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[_User] ON 

INSERT [dbo].[_User] ([_id], [firstname], [lastname], [slug], [id_card], [email], [phone], [isEmalActive], [isPhoneActive], [salt], [hashed_password], [_role], [addresses], [avatar], [cover], [point], [e_wallet], [createdAt], [updatedAt]) VALUES (1, N'minh', N'pham', N'SEOminhpham', N'00001', N'minh@gmail.com', N'00001', 0, 0, N'00001', N'123456', N'Admin', N'hcm', N'user/1671355171516.png', NULL, 0, CAST(0.0000 AS Decimal(10, 4)), CAST(N'2022-12-18T16:19:31.567' AS DateTime), CAST(N'2022-12-18T19:29:55.323' AS DateTime))
INSERT [dbo].[_User] ([_id], [firstname], [lastname], [slug], [id_card], [email], [phone], [isEmalActive], [isPhoneActive], [salt], [hashed_password], [_role], [addresses], [avatar], [cover], [point], [e_wallet], [createdAt], [updatedAt]) VALUES (2, N'Duyen', N'Lam', N'SEODuyenLam', N'00002', N'duyen@gmail.com', N'00002', 0, 0, N'00002', N'123456', N'Staff', N'hcm', N'user/1671355251713.png', NULL, 0, CAST(0.0000 AS Decimal(10, 4)), CAST(N'2022-12-18T16:20:51.743' AS DateTime), CAST(N'2022-12-18T19:29:55.323' AS DateTime))
INSERT [dbo].[_User] ([_id], [firstname], [lastname], [slug], [id_card], [email], [phone], [isEmalActive], [isPhoneActive], [salt], [hashed_password], [_role], [addresses], [avatar], [cover], [point], [e_wallet], [createdAt], [updatedAt]) VALUES (3, N'nhu', N'nguyen', N'SEOnhunguyen', N'00003', N'nhu@gmail.com', N'00003', 0, 0, NULL, N'1', N'user', NULL, NULL, NULL, 0, CAST(0.0000 AS Decimal(10, 4)), CAST(N'2022-12-18T18:38:47.737' AS DateTime), CAST(N'2022-12-18T19:29:55.323' AS DateTime))
SET IDENTITY_INSERT [dbo].[_User] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([_id], [_name], [slug], [categoryId], [_image], [isDeleted], [createdAt], [updatedAt]) VALUES (1, N'Children Bicycles', N'SEOChildren Bicycles', NULL, N'category/1671355449088.png', 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Category] ([_id], [_name], [slug], [categoryId], [_image], [isDeleted], [createdAt], [updatedAt]) VALUES (2, N'Comfort Bicycles', N'SEOComfort Bicycles', NULL, N'category/1671355459088.png', 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Category] ([_id], [_name], [slug], [categoryId], [_image], [isDeleted], [createdAt], [updatedAt]) VALUES (3, N'Cruisers Bicycles', N'SEOCruisers Bicycles', NULL, N'category/1671355468422.png', 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Category] ([_id], [_name], [slug], [categoryId], [_image], [isDeleted], [createdAt], [updatedAt]) VALUES (4, N'Cyclocross Bicycles', N'SEOCyclocross Bicycles', NULL, N'category/1671355477352.png', 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Category] ([_id], [_name], [slug], [categoryId], [_image], [isDeleted], [createdAt], [updatedAt]) VALUES (5, N'Electric Bikes', N'SEOElectric Bikes', NULL, N'category/1671355485749.png', 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Category] ([_id], [_name], [slug], [categoryId], [_image], [isDeleted], [createdAt], [updatedAt]) VALUES (6, N'Mountain Bikes', N'SEOMountain Bikes', NULL, N'category/1671355494612.png', 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Category] ([_id], [_name], [slug], [categoryId], [_image], [isDeleted], [createdAt], [updatedAt]) VALUES (7, N'Road Bikes', N'SEORoad Bikes', NULL, N'category/1671355503470.png', 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Delivery] ON 

INSERT [dbo].[Delivery] ([_id], [name], [description], [price], [isDeleted], [createdAt], [updatedAt]) VALUES (1, N'Shoppee', N'Shoppee', CAST(10 AS Decimal(18, 0)), 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Delivery] ([_id], [name], [description], [price], [isDeleted], [createdAt], [updatedAt]) VALUES (2, N'Tiki', N'Tiki', CAST(15 AS Decimal(18, 0)), 0, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
SET IDENTITY_INSERT [dbo].[Delivery] OFF
GO
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (1, N'product/1671359893549.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (2, N'product/1671359994284.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (3, N'product/1671359936211.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (4, N'product/1671360004760.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (7, N'product/1671360149933.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (8, N'product/1671360161887.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (9, N'product/1671360167557.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (16, N'product/1671360305961.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (17, N'product/1671360310412.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (18, N'product/1671360335115.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (19, N'product/1671360344776.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (20, N'product/1671360361985.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (21, N'product/1671360367767.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (32, N'product/1671360693605.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (32, N'product/1671360703889.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (34, N'product/1671360715042.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (34, N'product/1671360750059.png')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (36, N'product/1671360765132.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (43, N'product/1671360971240.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (44, N'product/1671360975485.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (52, N'product/1671361093762.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (53, N'product/1671361142066.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (54, N'product/1671361147035.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (55, N'product/1671361151697.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (56, N'product/1671361161186.png')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (57, N'product/1671361178125.png')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (58, N'product/1671361183181.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (59, N'product/1671361199852.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (60, N'product/1671361204877.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (61, N'product/1671361210215.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (62, N'product/1671361216309.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (68, N'product/1671361307720.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (69, N'product/1671361322718.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (70, N'product/1671361327454.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (71, N'product/1671361340114.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (72, N'product/1671361349810.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (73, N'product/1671361359596.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (74, N'product/1671361366012.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (75, N'product/1671361377262.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (76, N'product/1671361383274.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (77, N'product/1671361389373.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (78, N'product/1671361423360.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (79, N'product/1671361434701.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (83, N'product/1671361577501.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (84, N'product/1671361603900.png')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (85, N'product/1671361618690.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (86, N'product/1671361650405.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (87, N'product/1671361659133.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (88, N'product/1671361665063.jpeg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (5, N'product/1671359999360.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (6, N'product/1671360053272.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (10, N'product/1671360112861.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (11, N'product/1671360126134.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (12, N'product/1671360131618.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (13, N'product/1671360136334.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (14, N'product/1671360141965.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (15, N'product/1671360156337.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (22, N'product/1671360299203.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (23, N'product/1671360316700.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (24, N'product/1671360323127.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (25, N'product/1671360330296.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (26, N'product/1671360340054.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (27, N'product/1671360349328.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (28, N'product/1671360374432.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (28, N'product/1671360380826.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (28, N'product/1671360386951.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (37, N'product/1671360679318.png')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (38, N'product/1671360683949.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (39, N'product/1671360688889.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (40, N'product/1671360698335.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (41, N'product/1671360708720.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (42, N'product/1671360726888.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (42, N'product/1671360731759.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (41, N'product/1671360738257.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (40, N'product/1671360744527.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (39, N'product/1671360758580.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (44, N'product/1671360980939.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (45, N'product/1671360998367.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (46, N'product/1671361002596.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (47, N'product/1671361007208.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (48, N'product/1671361013280.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (49, N'product/1671361017896.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (50, N'product/1671361022727.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (51, N'product/1671361027059.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (63, N'product/1671361156754.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (64, N'product/1671361168611.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (65, N'product/1671361172848.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (66, N'product/1671361188457.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (67, N'product/1671361194109.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (80, N'product/1671361303025.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (81, N'product/1671361312443.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (82, N'product/1671361317274.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (89, N'product/1671361568734.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (90, N'product/1671361573279.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (91, N'product/1671361581860.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (92, N'product/1671361587544.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (93, N'product/1671361597020.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (94, N'product/1671361614268.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (95, N'product/1671361624382.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (96, N'product/1671361670897.jpg')
GO
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (97, N'product/1671361608836.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (98, N'product/1671361631426.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (99, N'product/1671361636659.jpg')
INSERT [dbo].[ListImagesProduct] ([_id], [image]) VALUES (100, N'product/1671361642306.jpg')
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (1, N'Electra Cruiser 1 (24-Inch) - 2016', N'SEOElectra Cruiser 1 (24-Inch) - 2016', N'Electra Cruiser 1 (24-Inch) - 2016', CAST(270 AS Decimal(18, 0)), CAST(270 AS Decimal(18, 0)), 7, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (2, N'Electra Girl''s Hawaii 1 (16-inch) - 2015/2016', N'SEOElectra Girl''s Hawaii 1 (16-inch) - 2015/2016', N'Electra Girl''s Hawaii 1 (16-inch) - 2015/2016', CAST(270 AS Decimal(18, 0)), CAST(270 AS Decimal(18, 0)), 22, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (3, N'Electra Girl''s Hawaii 1 (20-inch) - 2015/2016', N'SEOElectra Girl''s Hawaii 1 (20-inch) - 2015/2016', N'Electra Girl''s Hawaii 1 (20-inch) - 2015/2016', CAST(300 AS Decimal(18, 0)), CAST(300 AS Decimal(18, 0)), 3, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (4, N'Sun Bicycles Lil Kitt''n - 2017', N'SEOSun Bicycles Lil Kitt''n - 2017', N'Sun Bicycles Lil Kitt''n - 2017', CAST(110 AS Decimal(18, 0)), CAST(110 AS Decimal(18, 0)), 11, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (5, N'Haro Downtown 16 - 2017', N'SEOHaro Downtown 16 - 2017', N'Haro Downtown 16 - 2017', CAST(330 AS Decimal(18, 0)), CAST(330 AS Decimal(18, 0)), 24, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (6, N'Trek Girl''s Kickster - 2017', N'SEOTrek Girl''s Kickster - 2017', N'Trek Girl''s Kickster - 2017', CAST(150 AS Decimal(18, 0)), CAST(150 AS Decimal(18, 0)), 19, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (7, N'Trek Precaliber 12 Boys - 2017', N'SEOTrek Precaliber 12 Boys - 2017', N'Trek Precaliber 12 Boys - 2017', CAST(190 AS Decimal(18, 0)), CAST(190 AS Decimal(18, 0)), 32, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (8, N'Trek Precaliber 12 Girls - 2017', N'SEOTrek Precaliber 12 Girls - 2017', N'Trek Precaliber 12 Girls - 2017', CAST(190 AS Decimal(18, 0)), CAST(190 AS Decimal(18, 0)), 9, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (9, N'Trek Precaliber 16 Boys - 2017', N'SEOTrek Precaliber 16 Boys - 2017', N'Trek Precaliber 16 Boys - 2017', CAST(210 AS Decimal(18, 0)), CAST(210 AS Decimal(18, 0)), 6, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (10, N'Trek Precaliber 16 Girls - 2017', N'SEOTrek Precaliber 16 Girls - 2017', N'Trek Precaliber 16 Girls - 2017', CAST(210 AS Decimal(18, 0)), CAST(210 AS Decimal(18, 0)), 10, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (11, N'Trek Precaliber 24 (21-Speed) - Girls - 2017', N'SEOTrek Precaliber 24 (21-Speed) - Girls - 2017', N'Trek Precaliber 24 (21-Speed) - Girls - 2017', CAST(350 AS Decimal(18, 0)), CAST(350 AS Decimal(18, 0)), 9, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (12, N'Haro Shredder 20 - 2017', N'SEOHaro Shredder 20 - 2017', N'Haro Shredder 20 - 2017', CAST(210 AS Decimal(18, 0)), CAST(210 AS Decimal(18, 0)), 11, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (13, N'Haro Shredder 20 Girls - 2017', N'SEOHaro Shredder 20 Girls - 2017', N'Haro Shredder 20 Girls - 2017', CAST(210 AS Decimal(18, 0)), CAST(210 AS Decimal(18, 0)), 10, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (14, N'Haro Shredder Pro 20 - 2017', N'SEOHaro Shredder Pro 20 - 2017', N'Haro Shredder Pro 20 - 2017', CAST(250 AS Decimal(18, 0)), CAST(250 AS Decimal(18, 0)), 20, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (15, N'Trek Boy''s Kickster - 2015/2017', N'SEOTrek Boy''s Kickster - 2015/2017', N'Trek Boy''s Kickster - 2015/2017', CAST(150 AS Decimal(18, 0)), CAST(150 AS Decimal(18, 0)), 31, 0, 1, 1, 1, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (16, N'Electra Townie Original 21D - 2016', N'SEOElectra Townie Original 21D - 2016', N'Electra Townie Original 21D - 2016', CAST(550 AS Decimal(18, 0)), CAST(550 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (17, N'Electra Townie Original 7D - 2015/2016', N'SEOElectra Townie Original 7D - 2015/2016', N'Electra Townie Original 7D - 2015/2016', CAST(500 AS Decimal(18, 0)), CAST(500 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (18, N'Electra Townie Original 7D EQ - 2016', N'SEOElectra Townie Original 7D EQ - 2016', N'Electra Townie Original 7D EQ - 2016', CAST(600 AS Decimal(18, 0)), CAST(600 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (19, N'Electra Townie Original 7D - 2017', N'SEOElectra Townie Original 7D - 2017', N'Electra Townie Original 7D - 2017', CAST(490 AS Decimal(18, 0)), CAST(490 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (20, N'Sun Bicycles Streamway 3 - 2017', N'SEOSun Bicycles Streamway 3 - 2017', N'Sun Bicycles Streamway 3 - 2017', CAST(552 AS Decimal(18, 0)), CAST(552 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (21, N'Sun Bicycles Streamway - 2017', N'SEOSun Bicycles Streamway - 2017', N'Sun Bicycles Streamway - 2017', CAST(482 AS Decimal(18, 0)), CAST(482 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (22, N'Sun Bicycles Streamway 7 - 2017', N'SEOSun Bicycles Streamway 7 - 2017', N'Sun Bicycles Streamway 7 - 2017', CAST(534 AS Decimal(18, 0)), CAST(534 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (23, N'Sun Bicycles Cruz 3 - 2017', N'SEOSun Bicycles Cruz 3 - 2017', N'Sun Bicycles Cruz 3 - 2017', CAST(450 AS Decimal(18, 0)), CAST(450 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (24, N'Sun Bicycles Cruz 7 - 2017', N'SEOSun Bicycles Cruz 7 - 2017', N'Sun Bicycles Cruz 7 - 2017', CAST(417 AS Decimal(18, 0)), CAST(417 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (25, N'Sun Bicycles Cruz 3 - Women''s - 2017', N'SEOSun Bicycles Cruz 3 - Women''s - 2017', N'Sun Bicycles Cruz 3 - Women''s - 2017', CAST(450 AS Decimal(18, 0)), CAST(450 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (26, N'Sun Bicycles Cruz 7 - Women''s - 2017', N'SEOSun Bicycles Cruz 7 - Women''s - 2017', N'Sun Bicycles Cruz 7 - Women''s - 2017', CAST(417 AS Decimal(18, 0)), CAST(417 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (27, N'Sun Bicycles Drifter 7 - 2017', N'SEOSun Bicycles Drifter 7 - 2017', N'Sun Bicycles Drifter 7 - 2017', CAST(471 AS Decimal(18, 0)), CAST(471 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (28, N'Sun Bicycles Drifter 7 - Women''s - 2017', N'SEOSun Bicycles Drifter 7 - Women''s - 2017', N'Sun Bicycles Drifter 7 - Women''s - 2017', CAST(471 AS Decimal(18, 0)), CAST(471 AS Decimal(18, 0)), 31, 0, 1, 1, 2, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (32, N'Electra Moto 1 - 2016', N'SEOElectra Moto 1 - 2016', N'Electra Moto 1 - 2016', CAST(530 AS Decimal(18, 0)), CAST(530 AS Decimal(18, 0)), 8, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (34, N'Pure Cycles Vine 8-Speed - 2016', N'SEOPure Cycles Vine 8-Speed - 2016', N'Pure Cycles Vine 8-Speed - 2016', CAST(429 AS Decimal(18, 0)), CAST(429 AS Decimal(18, 0)), 11, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (36, N'Pure Cycles William 3-Speed - 2016', N'SEOPure Cycles William 3-Speed - 2016', N'Pure Cycles William 3-Speed - 2016', CAST(449 AS Decimal(18, 0)), CAST(449 AS Decimal(18, 0)), 11, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (37, N'Electra Townie Original 7D EQ - Women''s - 2016', N'SEOElectra Townie Original 7D EQ - Women''s - 2016', N'Electra Townie Original 7D EQ - Women''s - 2016', CAST(600 AS Decimal(18, 0)), CAST(600 AS Decimal(18, 0)), 21, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (38, N'Electra Cruiser 1 Ladies'' - 2018', N'SEOElectra Cruiser 1 Ladies'' - 2018', N'Electra Cruiser 1 Ladies'' - 2018', CAST(270 AS Decimal(18, 0)), CAST(270 AS Decimal(18, 0)), 6, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (39, N'Electra Cruiser 7D Ladies'' - 2016/2018', N'SEOElectra Cruiser 7D Ladies'' - 2016/2018', N'Electra Cruiser 7D Ladies'' - 2016/2018', CAST(320 AS Decimal(18, 0)), CAST(320 AS Decimal(18, 0)), 21, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (40, N'Electra Cruiser 1 Tall - 2016/2018', N'SEOElectra Cruiser 1 Tall - 2016/2018', N'Electra Cruiser 1 Tall - 2016/2018', CAST(270 AS Decimal(18, 0)), CAST(270 AS Decimal(18, 0)), 22, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (41, N'Electra Cruiser Lux 3i - 2018', N'SEOElectra Cruiser Lux 3i - 2018', N'Electra Cruiser Lux 3i - 2018', CAST(530 AS Decimal(18, 0)), CAST(530 AS Decimal(18, 0)), 23, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (42, N'Electra Cruiser Lux 7D - 2018', N'SEOElectra Cruiser Lux 7D - 2018', N'Electra Cruiser Lux 7D - 2018', CAST(480 AS Decimal(18, 0)), CAST(480 AS Decimal(18, 0)), 23, 0, 1, 1, 3, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (43, N'Surly Straggler - 2016', N'SEOSurly Straggler - 2016', N'Surly Straggler - 2016', CAST(1549 AS Decimal(18, 0)), CAST(1549 AS Decimal(18, 0)), 19, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (44, N'Surly Straggler 650b - 2016', N'SEOSurly Straggler 650b - 2016', N'Surly Straggler 650b - 2016', CAST(1681 AS Decimal(18, 0)), CAST(1681 AS Decimal(18, 0)), 20, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (45, N'Trek Boone 5 Disc - 2018', N'SEOTrek Boone 5 Disc - 2018', N'Trek Boone 5 Disc - 2018', CAST(3300 AS Decimal(18, 0)), CAST(3300 AS Decimal(18, 0)), 22, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (46, N'Trek Boone 7 Disc - 2018', N'SEOTrek Boone 7 Disc - 2018', N'Trek Boone 7 Disc - 2018', CAST(4000 AS Decimal(18, 0)), CAST(4000 AS Decimal(18, 0)), 23, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (47, N'Trek Crockett 5 Disc - 2018', N'SEOTrek Crockett 5 Disc - 2018', N'Trek Crockett 5 Disc - 2018', CAST(1800 AS Decimal(18, 0)), CAST(1800 AS Decimal(18, 0)), 24, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (48, N'Trek Crockett 7 Disc - 2018', N'SEOTrek Crockett 7 Disc - 2018', N'Trek Crockett 7 Disc - 2018', CAST(3000 AS Decimal(18, 0)), CAST(3000 AS Decimal(18, 0)), 40, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (49, N'Surly Straggler - 2018', N'SEOSurly Straggler - 2018', N'Surly Straggler - 2018', CAST(1549 AS Decimal(18, 0)), CAST(1549 AS Decimal(18, 0)), 8, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (50, N'Surly Straggler 650b - 2018', N'SEOSurly Straggler 650b - 2018', N'Surly Straggler 650b - 2018', CAST(1549 AS Decimal(18, 0)), CAST(1549 AS Decimal(18, 0)), 8, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (51, N'Trek Boone 7 - 2017', N'SEOTrek Boone 7 - 2017', N'Trek Boone 7 - 2017', CAST(3500 AS Decimal(18, 0)), CAST(3500 AS Decimal(18, 0)), 10, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (52, N'Trek Boone Race Shop Limited - 2017', N'SEOTrek Boone Race Shop Limited - 2017', N'Trek Boone Race Shop Limited - 2017', CAST(3500 AS Decimal(18, 0)), CAST(3500 AS Decimal(18, 0)), 12, 0, 1, 1, 4, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (53, N'Sun Bicycles ElectroLite - 2017', N'SEOSun Bicycles ElectroLite - 2017', N'Sun Bicycles ElectroLite - 2017', CAST(1560 AS Decimal(18, 0)), CAST(1560 AS Decimal(18, 0)), 16, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (54, N'Trek Powerfly 8 FS Plus - 2017', N'SEOTrek Powerfly 8 FS Plus - 2017', N'Trek Powerfly 8 FS Plus - 2017', CAST(5000 AS Decimal(18, 0)), CAST(5000 AS Decimal(18, 0)), 9, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (55, N'Trek Lift+ Lowstep - 2018', N'SEOTrek Lift+ Lowstep - 2018', N'Trek Lift+ Lowstep - 2018', CAST(2800 AS Decimal(18, 0)), CAST(2800 AS Decimal(18, 0)), 9, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (56, N'Trek Dual Sport+ - 2018', N'SEOTrek Dual Sport+ - 2018', N'Trek Dual Sport+ - 2018', CAST(2800 AS Decimal(18, 0)), CAST(2800 AS Decimal(18, 0)), 9, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (57, N'Electra Loft Go! 8i - 2018', N'SEOElectra Loft Go! 8i - 2018', N'Electra Loft Go! 8i - 2018', CAST(2800 AS Decimal(18, 0)), CAST(2800 AS Decimal(18, 0)), 14, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (58, N'Electra Townie Go! 8i - 2017/2018', N'SEOElectra Townie Go! 8i - 2017/2018', N'Electra Townie Go! 8i - 2017/2018', CAST(2600 AS Decimal(18, 0)), CAST(2600 AS Decimal(18, 0)), 21, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (59, N'Trek Lift+ - 2018', N'SEOTrek Lift+ - 2018', N'Trek Lift+ - 2018', CAST(2800 AS Decimal(18, 0)), CAST(2800 AS Decimal(18, 0)), 20, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (60, N'Trek XM700+ - 2018', N'SEOTrek XM700+ - 2018', N'Trek XM700+ - 2018', CAST(3500 AS Decimal(18, 0)), CAST(3500 AS Decimal(18, 0)), 14, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (61, N'Electra Townie Go! 8i Ladies', N'SEOElectra Townie Go! 8i Ladies', N'Electra Townie Go! 8i Ladies', CAST(2600 AS Decimal(18, 0)), CAST(2600 AS Decimal(18, 0)), 7, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (62, N'Trek Verve+ - 2018', N'SEOTrek Verve+ - 2018', N'Trek Verve+ - 2018', CAST(2300 AS Decimal(18, 0)), CAST(2300 AS Decimal(18, 0)), 19, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (63, N'Trek Verve+ Lowstep - 2018', N'SEOTrek Verve+ Lowstep - 2018', N'Trek Verve+ Lowstep - 2018', CAST(2300 AS Decimal(18, 0)), CAST(2300 AS Decimal(18, 0)), 24, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (64, N'Electra Townie Commute Go! - 2018', N'SEOElectra Townie Commute Go! - 2018', N'Electra Townie Commute Go! - 2018', CAST(3000 AS Decimal(18, 0)), CAST(3000 AS Decimal(18, 0)), 21, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (65, N'Electra Townie Commute Go! Ladies', N'SEOElectra Townie Commute Go! Ladies', N'Electra Townie Commute Go! Ladies', CAST(3000 AS Decimal(18, 0)), CAST(3000 AS Decimal(18, 0)), 8, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (66, N'Trek Powerfly 5 - 2018', N'SEOTrek Powerfly 5 - 2018', N'Trek Powerfly 5 - 2018', CAST(3500 AS Decimal(18, 0)), CAST(3500 AS Decimal(18, 0)), 31, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (67, N'Trek Powerfly 5 FS - 2018', N'SEOTrek Powerfly 5 FS - 2018', N'Trek Powerfly 5 FS - 2018', CAST(4500 AS Decimal(18, 0)), CAST(4500 AS Decimal(18, 0)), 23, 0, 1, 1, 5, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (68, N'Trek 820 - 2016', N'SEOTrek 820 - 2016', N'Trek 820 - 2016', CAST(380 AS Decimal(18, 0)), CAST(380 AS Decimal(18, 0)), 9, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (69, N'Ritchey Timberwolf Frameset - 2016', N'SEORitchey Timberwolf Frameset - 2016', N'Ritchey Timberwolf Frameset - 2016', CAST(750 AS Decimal(18, 0)), CAST(750 AS Decimal(18, 0)), 26, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (70, N'Surly Wednesday Frameset - 2016', N'SEOSurly Wednesday Frameset - 2016', N'Surly Wednesday Frameset - 2016', CAST(1000 AS Decimal(18, 0)), CAST(1000 AS Decimal(18, 0)), 21, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (71, N'Trek Fuel EX 8 29 - 2016', N'SEOTrek Fuel EX 8 29 - 2016', N'Trek Fuel EX 8 29 - 2016', CAST(2900 AS Decimal(18, 0)), CAST(2900 AS Decimal(18, 0)), 26, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (72, N'Heller Shagamaw Frame - 2016', N'SEOHeller Shagamaw Frame - 2016', N'Heller Shagamaw Frame - 2016', CAST(1321 AS Decimal(18, 0)), CAST(1321 AS Decimal(18, 0)), 20, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (73, N'Surly Ice Cream Truck Frameset - 2016', N'SEOSurly Ice Cream Truck Frameset - 2016', N'Surly Ice Cream Truck Frameset - 2016', CAST(470 AS Decimal(18, 0)), CAST(470 AS Decimal(18, 0)), 18, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (74, N'Trek Slash 8 27.5 - 2016', N'SEOTrek Slash 8 27.5 - 2016', N'Trek Slash 8 27.5 - 2016', CAST(4000 AS Decimal(18, 0)), CAST(4000 AS Decimal(18, 0)), 21, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (75, N'Trek Remedy 29 Carbon Frameset - 2016', N'SEOTrek Remedy 29 Carbon Frameset - 2016', N'Trek Remedy 29 Carbon Frameset - 2016', CAST(1800 AS Decimal(18, 0)), CAST(1800 AS Decimal(18, 0)), 18, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (76, N'Haro Shift R3 - 2017', N'SEOHaro Shift R3 - 2017', N'Haro Shift R3 - 2017', CAST(1470 AS Decimal(18, 0)), CAST(1470 AS Decimal(18, 0)), 8, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (77, N'Trek Fuel EX 5 27.5 Plus - 2017', N'SEOTrek Fuel EX 5 27.5 Plus - 2017', N'Trek Fuel EX 5 27.5 Plus - 2017', CAST(2300 AS Decimal(18, 0)), CAST(2300 AS Decimal(18, 0)), 20, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (78, N'Trek Fuel EX 9.8 27.5 Plus - 2017', N'SEOTrek Fuel EX 9.8 27.5 Plus - 2017', N'Trek Fuel EX 9.8 27.5 Plus - 2017', CAST(5300 AS Decimal(18, 0)), CAST(5300 AS Decimal(18, 0)), 25, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (79, N'Haro SR 1.1 - 2017', N'SEOHaro SR 1.1 - 2017', N'Haro SR 1.1 - 2017', CAST(540 AS Decimal(18, 0)), CAST(540 AS Decimal(18, 0)), 12, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (80, N'Haro SR 1.2 - 2017', N'SEOHaro SR 1.2 - 2017', N'Haro SR 1.2 - 2017', CAST(870 AS Decimal(18, 0)), CAST(870 AS Decimal(18, 0)), 10, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (81, N'Haro SR 1.3 - 2017', N'SEOHaro SR 1.3 - 2017', N'Haro SR 1.3 - 2017', CAST(1410 AS Decimal(18, 0)), CAST(1410 AS Decimal(18, 0)), 7, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (82, N'Trek Remedy 9.8 - 2017', N'SEOTrek Remedy 9.8 - 2017', N'Trek Remedy 9.8 - 2017', CAST(5300 AS Decimal(18, 0)), CAST(5300 AS Decimal(18, 0)), 23, 0, 1, 1, 6, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (83, N'Trek Emonda S 4 - 2017', N'SEOTrek Emonda S 4 - 2017', N'Trek Emonda S 4 - 2017', CAST(1500 AS Decimal(18, 0)), CAST(1500 AS Decimal(18, 0)), 30, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (84, N'Trek Domane SL 6 - 2017', N'SEOTrek Domane SL 6 - 2017', N'Trek Domane SL 6 - 2017', CAST(3500 AS Decimal(18, 0)), CAST(3500 AS Decimal(18, 0)), 15, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (85, N'Trek Silque SLR 7 Women - 2017', N'SEOTrek Silque SLR 7 Women - 2017', N'Trek Silque SLR 7 Women - 2017', CAST(6000 AS Decimal(18, 0)), CAST(6000 AS Decimal(18, 0)), 19, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (86, N'Trek Silque SLR 8 Women - 2017', N'SEOTrek Silque SLR 8 Women - 2017', N'Trek Silque SLR 8 Women - 2017', CAST(6500 AS Decimal(18, 0)), CAST(6500 AS Decimal(18, 0)), 9, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (87, N'Surly Steamroller - 2017', N'SEOSurly Steamroller - 2017', N'Surly Steamroller - 2017', CAST(876 AS Decimal(18, 0)), CAST(876 AS Decimal(18, 0)), 20, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (88, N'Surly Ogre Frameset - 2017', N'SEOSurly Ogre Frameset - 2017', N'Surly Ogre Frameset - 2017', CAST(750 AS Decimal(18, 0)), CAST(750 AS Decimal(18, 0)), 20, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (89, N'Trek Domane SL Disc Frameset - 2017', N'SEOTrek Domane SL Disc Frameset - 2017', N'Trek Domane SL Disc Frameset - 2017', CAST(3200 AS Decimal(18, 0)), CAST(3200 AS Decimal(18, 0)), 14, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (90, N'Trek Domane S 6 - 2017', N'SEOTrek Domane S 6 - 2017', N'Trek Domane S 6 - 2017', CAST(2700 AS Decimal(18, 0)), CAST(2700 AS Decimal(18, 0)), 20, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (91, N'Trek Domane SLR 6 Disc - 2017', N'SEOTrek Domane SLR 6 Disc - 2017', N'Trek Domane SLR 6 Disc - 2017', CAST(5500 AS Decimal(18, 0)), CAST(5500 AS Decimal(18, 0)), 11, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (92, N'Trek Emonda S 5 - 2017', N'SEOTrek Emonda S 5 - 2017', N'Trek Emonda S 5 - 2017', CAST(2000 AS Decimal(18, 0)), CAST(2000 AS Decimal(18, 0)), 23, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (93, N'Trek Madone 9.2 - 2017', N'SEOTrek Madone 9.2 - 2017', N'Trek Madone 9.2 - 2017', CAST(5000 AS Decimal(18, 0)), CAST(5000 AS Decimal(18, 0)), 23, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (94, N'Trek Domane S 5 Disc - 2017', N'SEOTrek Domane S 5 Disc - 2017', N'Trek Domane S 5 Disc - 2017', CAST(2600 AS Decimal(18, 0)), CAST(2600 AS Decimal(18, 0)), 11, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (95, N'Trek Checkpoint ALR 4 Women - 2019', N'SEOTrek Checkpoint ALR 4 Women - 2019', N'Trek Checkpoint ALR 4 Women - 2019', CAST(1700 AS Decimal(18, 0)), CAST(1700 AS Decimal(18, 0)), 19, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (96, N'Trek Checkpoint ALR 5 - 2019', N'SEOTrek Checkpoint ALR 5 - 2019', N'Trek Checkpoint ALR 5 - 2019', CAST(2000 AS Decimal(18, 0)), CAST(2000 AS Decimal(18, 0)), 29, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (97, N'Trek Checkpoint ALR 5 Women - 2019', N'SEOTrek Checkpoint ALR 5 Women - 2019', N'Trek Checkpoint ALR 5 Women - 2019', CAST(2000 AS Decimal(18, 0)), CAST(2000 AS Decimal(18, 0)), 26, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (98, N'Trek Checkpoint SL 5 Women - 2019', N'SEOTrek Checkpoint SL 5 Women - 2019', N'Trek Checkpoint SL 5 Women - 2019', CAST(2800 AS Decimal(18, 0)), CAST(2800 AS Decimal(18, 0)), 16, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (99, N'Trek Checkpoint SL 6 - 2019', N'SEOTrek Checkpoint SL 6 - 2019', N'Trek Checkpoint SL 6 - 2019', CAST(3800 AS Decimal(18, 0)), CAST(3800 AS Decimal(18, 0)), 13, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
INSERT [dbo].[Product] ([_id], [name], [slug], [description], [price], [promotionalPrice], [quantity], [sold], [isActive], [isSelling], [categoryId], [storeId], [isDeleted], [rating], [createdAt], [updatedAt]) VALUES (100, N'Trek Checkpoint ALR Frameset - 2019', N'SEOTrek Checkpoint ALR Frameset - 2019', N'Trek Checkpoint ALR Frameset - 2019', CAST(3200 AS Decimal(18, 0)), CAST(3200 AS Decimal(18, 0)), 13, 0, 1, 1, 7, 1, 0, 3, CAST(N'2022-12-18' AS Date), CAST(N'2022-12-18' AS Date))
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Store] ON 

INSERT [dbo].[Store] ([_id], [_name], [bio], [slug], [ownerId], [isActive], [isOpen], [avatar], [cover], [featured_images], [commissionId], [point], [rating], [e_wallet], [createdAt], [updatedAt]) VALUES (1, N'Cua hang lon', N'Ban xe dap', N'SEOCua hang lon', 2, 0, 0, N'store/1671355328329.png', NULL, NULL, NULL, 0, 3, CAST(0.0000 AS Decimal(10, 4)), CAST(N'2022-12-18T16:22:08.417' AS DateTime), CAST(N'2022-12-18T16:22:08.443' AS DateTime))
SET IDENTITY_INSERT [dbo].[Store] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ___User__AB6E61640342E7DC]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[_User] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ___User__B43B145F2ACBF54B]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[_User] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ___User__C71FE366DD865533]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[_User] ADD UNIQUE NONCLUSTERED 
(
	[id_card] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Category__019A50BF6D7A443D]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Category] ADD UNIQUE NONCLUSTERED 
(
	[_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Category__32DD1E4C90896173]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Category] ADD UNIQUE NONCLUSTERED 
(
	[slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Commissi__019A50BF05EF1D26]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Commission] ADD UNIQUE NONCLUSTERED 
(
	[_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Commissi__357CB607831F0897]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Commission] ADD UNIQUE NONCLUSTERED 
(
	[cost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Commissi__4C49DA3DBDDCEBEE]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Commission] ADD UNIQUE NONCLUSTERED 
(
	[_description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Delivery__72E12F1BA63C4472]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Delivery] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Product__32DD1E4C11EB7D47]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Product] ADD UNIQUE NONCLUSTERED 
(
	[slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Product__72E12F1BD2952F6D]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Product] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Store__019A50BFA5D98DC0]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Store] ADD UNIQUE NONCLUSTERED 
(
	[_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Store__32DD1E4C94D5BFFD]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Store] ADD UNIQUE NONCLUSTERED 
(
	[slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Style__72E12F1BD3F93BB5]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[Style] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__StyleVal__72E12F1BE483EB11]    Script Date: 12/18/2022 7:46:38 PM ******/
ALTER TABLE [dbo].[StyleValue] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_Order] ADD  DEFAULT (N'not precessed') FOR [status]
GO
ALTER TABLE [dbo].[_Order] ADD  DEFAULT ((0)) FOR [isPaidBefore]
GO
ALTER TABLE [dbo].[_Order] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[_Order] ADD  DEFAULT (getdate()) FOR [updatedAT]
GO
ALTER TABLE [dbo].[_User] ADD  DEFAULT ((0)) FOR [isEmalActive]
GO
ALTER TABLE [dbo].[_User] ADD  DEFAULT ((0)) FOR [isPhoneActive]
GO
ALTER TABLE [dbo].[_User] ADD  DEFAULT ('user') FOR [_role]
GO
ALTER TABLE [dbo].[_User] ADD  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[_User] ADD  DEFAULT ((0)) FOR [e_wallet]
GO
ALTER TABLE [dbo].[_User] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[_User] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [updatedAT]
GO
ALTER TABLE [dbo].[CartItem] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[CartItem] ADD  DEFAULT (getdate()) FOR [updatedAT]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[Commission] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Commission] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Commission] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[Delivery] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Delivery] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Delivery] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[OrderItem] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[OrderItem] ADD  DEFAULT (getdate()) FOR [updatedAT]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [sold]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((1)) FOR [isSelling]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((3)) FOR [rating]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT ((0)) FOR [isOpen]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT ((3)) FOR [rating]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT ((0)) FOR [e_wallet]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[Style] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Style] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Style] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[StyleValue] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[StyleValue] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[StyleValue] ADD  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[_Order]  WITH CHECK ADD FOREIGN KEY([commissionId])
REFERENCES [dbo].[Commission] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[_Order]  WITH CHECK ADD FOREIGN KEY([deliveryId])
REFERENCES [dbo].[Delivery] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[_Order]  WITH CHECK ADD FOREIGN KEY([storeId])
REFERENCES [dbo].[Store] ([_id])
GO
ALTER TABLE [dbo].[_Order]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[_User] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([storetId])
REFERENCES [dbo].[Store] ([_id])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[_User] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD FOREIGN KEY([cartId])
REFERENCES [dbo].[Cart] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([_id])
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([_id])
GO
ALTER TABLE [dbo].[ListImagesProduct]  WITH CHECK ADD FOREIGN KEY([_id])
REFERENCES [dbo].[Product] ([_id])
GO
ALTER TABLE [dbo].[ListImagesStore]  WITH CHECK ADD FOREIGN KEY([_id])
REFERENCES [dbo].[Store] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[_Order] ([_id])
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([_id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([storeId])
REFERENCES [dbo].[Store] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product_Style]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([_id])
GO
ALTER TABLE [dbo].[Product_Style]  WITH CHECK ADD FOREIGN KEY([StyleId])
REFERENCES [dbo].[Style] ([_id])
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD FOREIGN KEY([commissionId])
REFERENCES [dbo].[Commission] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD FOREIGN KEY([ownerId])
REFERENCES [dbo].[_User] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Store_Staff]  WITH CHECK ADD FOREIGN KEY([staffId])
REFERENCES [dbo].[_User] ([_id])
GO
ALTER TABLE [dbo].[Store_Staff]  WITH CHECK ADD FOREIGN KEY([storeId])
REFERENCES [dbo].[Store] ([_id])
GO
ALTER TABLE [dbo].[Style_Category]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([_id])
GO
ALTER TABLE [dbo].[Style_Category]  WITH CHECK ADD FOREIGN KEY([StyleId])
REFERENCES [dbo].[Style] ([_id])
GO
ALTER TABLE [dbo].[StyleValue]  WITH CHECK ADD FOREIGN KEY([styleId])
REFERENCES [dbo].[Style] ([_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[_Order]  WITH CHECK ADD CHECK  (([amountFromUser]>(-1) AND [amountFromStore]>(-1) AND [amountToStore]>(-1) AND [amountToGD]>(-1)))
GO
ALTER TABLE [dbo].[_User]  WITH CHECK ADD CHECK  (([e_wallet]>=(0)))
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD CHECK  (([count_SP]>(0)))
GO
ALTER TABLE [dbo].[Commission]  WITH CHECK ADD CHECK  (([cost]>=(0)))
GO
ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD CHECK  (([count_SP]>(0)))
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (([price]>=(0) AND [promotionalPrice]>=(0) AND [promotionalPrice]<=[price] AND [quantity]>=(0) AND [sold]>=(0) AND [rating]>(0) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD CHECK  (([rating]<=(5)))
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD CHECK  (([rating]<(6) AND [rating]>(0)))
GO

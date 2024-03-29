USE [ferreteria_jr]
GO
/****** Object:  Table [dbo].[users]    Script Date: 26/06/2023 18:05:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[password] [varchar](255) NOT NULL,
 CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_getUserid]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_getUserid](@id INT)
RETURNS table
as 
RETURN SELECT * FROM users u WHERE u.id  = @id;
GO
/****** Object:  Table [dbo].[status]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[id] [int] NOT NULL,
	[active] [bit] NOT NULL,
 CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [varchar](20) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[stock] [int] NOT NULL,
	[area_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[products_type_id] [int] NOT NULL,
	[expiration_date] [date] NULL,
 CONSTRAINT [PK_productos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_active_products]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_active_products] AS (
	SELECT * FROM products p
	WHERE p.status_id  = ( 
		SELECT id FROM status s 
		WHERE active = 1)
)
GO
/****** Object:  View [dbo].[view_deactivated_products]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_deactivated_products] AS (
	SELECT * FROM products p
	WHERE p.status_id  = ( 
		SELECT id FROM status s 
		WHERE active = 0)
);
GO
/****** Object:  UserDefinedFunction [dbo].[fn_getProductByid]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_getProductByid](@id INT)
RETURNS table
as 
RETURN SELECT * FROM products p WHERE p.id  = @id;
GO
/****** Object:  Table [dbo].[areas]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[areas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[status_id] [int] NOT NULL,
 CONSTRAINT [PK_areas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pdfs]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pdfs](
	[sales_id] [int] NOT NULL,
	[url] [varchar](255) NOT NULL,
 CONSTRAINT [PK_pdfs] PRIMARY KEY CLUSTERED 
(
	[sales_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products_types]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](100) NOT NULL,
 CONSTRAINT [PK_productos_tipo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NULL,
	[users_id] [int] NOT NULL,
	[customer] [varchar](200) NOT NULL,
	[dni] [char](8) NOT NULL,
 CONSTRAINT [PK_ventas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_details]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[producto_id] [varchar](20) NOT NULL,
	[sales_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_venta_detalles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[security]    Script Date: 26/06/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[security](
	[token] [varchar](255) NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_security_1] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[areas] ON 

INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (1, N'MATERIALES DE CONSTRUCCION', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (2, N'CARPINTERIA METALICA', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (3, N'PINTURA', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (4, N'ACCESORIOS PLASTICOS DE AGUA Y DESAGÜE', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (5, N'HERRAMIENTAS', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (6, N'CERRADURAS', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (7, N'PERNERIA', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (8, N'CARPINTERIA', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (9, N'PRODUCTOS DE LIMPIEZA', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (10, N'CLAVOS', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (12, N'ACCESORIOS ELECTRICOS', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (13, N'AREA DE PRUEBA ACTUALIZADA', 2)
INSERT [dbo].[areas] ([id], [name], [status_id]) VALUES (28, N'AREA DE PRUEBA', 1)
SET IDENTITY_INSERT [dbo].[areas] OFF
GO
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (3, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686849710/ferreteria_jr/pdfs/lixerie8.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (4, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686860262/ferreteria_jr/pdfs/lixl1nre.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (5, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686860475/ferreteria_jr/pdfs/lixl68kh.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (6, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686860503/ferreteria_jr/pdfs/lixl6u1t.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (7, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686860588/ferreteria_jr/pdfs/lixl8nlc.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (8, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686860708/ferreteria_jr/pdfs/lixlb7y4.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (9, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686860812/ferreteria_jr/pdfs/lixldgjb.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (10, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861024/ferreteria_jr/pdfs/lixlhzom.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (11, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861042/ferreteria_jr/pdfs/lixlidlw.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (12, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861106/ferreteria_jr/pdfs/lixljqsd.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (13, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861124/ferreteria_jr/pdfs/lixlk4wy.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (14, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861149/ferreteria_jr/pdfs/lixlkokv.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (15, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861283/ferreteria_jr/pdfs/lixlnjye.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (16, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861299/ferreteria_jr/pdfs/lixlnvv2.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (17, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861358/ferreteria_jr/pdfs/lixlp5c0.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (18, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861513/ferreteria_jr/pdfs/lixlshcl.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (19, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861585/ferreteria_jr/pdfs/lixlu0lk.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (20, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861602/ferreteria_jr/pdfs/lixlue41.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (21, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861709/ferreteria_jr/pdfs/lixlwomo.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (22, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861797/ferreteria_jr/pdfs/lixlykjo.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (23, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861811/ferreteria_jr/pdfs/lixlyv6k.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (24, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861829/ferreteria_jr/pdfs/lixlz90s.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (25, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861849/ferreteria_jr/pdfs/lixlzooj.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (26, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686861873/ferreteria_jr/pdfs/lixm078q.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (27, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686863195/ferreteria_jr/pdfs/lixmsiqg.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (28, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686863209/ferreteria_jr/pdfs/lixmsuaj.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (29, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686863798/ferreteria_jr/pdfs/lixn5gep.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (30, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686863811/ferreteria_jr/pdfs/lixn5qst.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (31, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686863826/ferreteria_jr/pdfs/lixn622m.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (32, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686931066/ferreteria_jr/pdfs/liyr78f3.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (33, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686931204/ferreteria_jr/pdfs/liyra715.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (34, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686965592/ferreteria_jr/pdfs/lizbr8nn.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (35, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686972487/ferreteria_jr/pdfs/lizfuztr.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (36, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686972512/ferreteria_jr/pdfs/lizfvju7.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (37, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686986169/ferreteria_jr/pdfs/lizo08z4.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (38, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686986188/ferreteria_jr/pdfs/lizo0nxh.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (39, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686986198/ferreteria_jr/pdfs/lizo0vuy.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (40, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1686986246/ferreteria_jr/pdfs/lizo1x3s.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (41, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687105365/ferreteria_jr/pdfs/lj1mz32k.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (42, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687132816/ferreteria_jr/pdfs/lj23bfn2.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (43, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687231879/ferreteria_jr/pdfs/lj3qaopn.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (45, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687288108/ferreteria_jr/pdfs/lj4nruo2.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (46, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687288170/ferreteria_jr/pdfs/lj4nt77n.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (47, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687288855/ferreteria_jr/pdfs/lj4o7urg.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (48, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687377923/ferreteria_jr/pdfs/lj658x2l.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (49, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687409121/ferreteria_jr/pdfs/lj6ntn64.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (50, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687567268/ferreteria_jr/pdfs/lj99z9wj.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (51, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687622121/ferreteria_jr/pdfs/lja6mygs.pdf')
INSERT [dbo].[pdfs] ([sales_id], [url]) VALUES (52, N'https://res.cloudinary.com/dcyv3nzsg/raw/upload/v1687625119/ferreteria_jr/pdfs/lja8f88n.pdf')
GO
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'1', N'Armella de 3/8', CAST(0.30 AS Decimal(18, 2)), 140, 7, 1, 7, CAST(N'2023-07-09' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'10', N'Tinte de madera GLUCOM', CAST(15.00 AS Decimal(18, 2)), 19, 8, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'100', N'Bisagra de pin 2x3/8', CAST(1.50 AS Decimal(18, 2)), 195, 6, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'101', N'Candado N 65 mm', CAST(13.00 AS Decimal(18, 2)), 170, 6, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'102', N'Candado N 50 mm', CAST(10.00 AS Decimal(18, 2)), 191, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'103', N'Candado N 38 mm', CAST(6.00 AS Decimal(18, 2)), 27, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'104', N'Lija para agua', CAST(2.00 AS Decimal(18, 2)), 64, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'105', N'Lija para fierro', CAST(3.00 AS Decimal(18, 2)), 95, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'106', N'Barniz transparente de 1/4 Galón (US 3,785)', CAST(35.00 AS Decimal(18, 2)), 32, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'107', N'Impermeabilizante SIKA 1 Lt Galón (US 3,785)', CAST(35.00 AS Decimal(18, 2)), 95, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'108', N'Cera Blanca LT', CAST(18.00 AS Decimal(18, 2)), 148, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'109', N'Cera Siliconada Lit', CAST(7.00 AS Decimal(18, 2)), 128, 3, 2, 4, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'11', N'Tinte de madera PARACAS', CAST(22.00 AS Decimal(18, 2)), 34, 8, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'110', N'Cizaya de 24 pulg', CAST(60.00 AS Decimal(18, 2)), 140, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'111', N'Puntas de Fierro', CAST(6.00 AS Decimal(18, 2)), 72, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'112', N'Arco de sierra Econm.', CAST(10.00 AS Decimal(18, 2)), 126, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'113', N'Arco de sierra Pretul', CAST(18.00 AS Decimal(18, 2)), 87, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'114', N'Serrucho Profield de 18 pulg', CAST(18.00 AS Decimal(18, 2)), 159, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'115', N'Serrucho Pretul de 20 pulg', CAST(18.00 AS Decimal(18, 2)), 12, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'116', N'Escobilla de fierro Truper', CAST(8.00 AS Decimal(18, 2)), 119, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'117', N'Escobilla de fierro econom', CAST(5.00 AS Decimal(18, 2)), 151, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'118', N'Nivel de Mano Truper', CAST(25.00 AS Decimal(18, 2)), 154, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'119', N'Plancha de batir mango goma', CAST(18.00 AS Decimal(18, 2)), 156, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'12', N'Hoja de sierra SANDFLEX', CAST(6.00 AS Decimal(18, 2)), 94, 8, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'120', N'Bruña de canto y centro econom', CAST(6.00 AS Decimal(18, 2)), 39, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'121', N'Chapa Forte Barra 226', CAST(63.00 AS Decimal(18, 2)), 86, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'122', N'Chapa Forte Pin 240', CAST(63.00 AS Decimal(18, 2)), 97, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'123', N'Lentes Oscuros', CAST(8.00 AS Decimal(18, 2)), 34, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'124', N'Lentes transparentes', CAST(6.00 AS Decimal(18, 2)), 104, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'125', N'Varillas de Bronce', CAST(4.00 AS Decimal(18, 2)), 117, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'126', N'Soldadura Punto Azul 1/8', CAST(17.00 AS Decimal(18, 2)), 30, 1, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'127', N'Disco Flat de 4 1/2', CAST(6.00 AS Decimal(18, 2)), 40, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'128', N'Disco de desbaste 7 1/2', CAST(9.00 AS Decimal(18, 2)), 33, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'129', N'Disco de desbaste 4 1/2', CAST(6.00 AS Decimal(18, 2)), 105, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'13', N'Cinta teflón', CAST(1.00 AS Decimal(18, 2)), 24, 4, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'130', N'Disco Corte madera 10', CAST(25.00 AS Decimal(18, 2)), 70, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'131', N'Tiralinea TRUPER', CAST(20.00 AS Decimal(18, 2)), 156, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'132', N'Tiralineas Econom', CAST(10.00 AS Decimal(18, 2)), 2, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'133', N'Spray Cromado', CAST(10.00 AS Decimal(18, 2)), 28, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'134', N'Spray de color', CAST(8.00 AS Decimal(18, 2)), 13, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'135', N'Rodillo Econom N 9', CAST(10.00 AS Decimal(18, 2)), 77, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'136', N'Rodillo Toro N9', CAST(18.00 AS Decimal(18, 2)), 49, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'137', N'Brocha de 6 pulg', CAST(10.00 AS Decimal(18, 2)), 31, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'138', N'Brocha de 4 pulg', CAST(7.00 AS Decimal(18, 2)), 51, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'139', N'Brocha de 3 pulg', CAST(6.00 AS Decimal(18, 2)), 125, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'14', N'Martillo Tramontina mango madera', CAST(30.00 AS Decimal(18, 2)), 97, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'140', N'Brocha de 2 pulg', CAST(3.00 AS Decimal(18, 2)), 136, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'141', N'Cintillos de 30 cm x 100 u', CAST(12.00 AS Decimal(18, 2)), 195, 5, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'142', N'Cintillos de 20 cm x 100 u', CAST(10.00 AS Decimal(18, 2)), 161, 5, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'143', N'Wincha pasa - cable de 15m', CAST(20.00 AS Decimal(18, 2)), 130, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'144', N'Wincha pasa-cable de 10 m', CAST(15.00 AS Decimal(18, 2)), 125, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'144EAXF', N'NUEVO PRODUCTO F.V', CAST(10.50 AS Decimal(18, 2)), 10, 2, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'145', N'Alambre Mellizo N° 16 INDECO', CAST(2.50 AS Decimal(18, 2)), 130, 1, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'146', N'Alambre Mellizo N° 18 INDECO', CAST(2.00 AS Decimal(18, 2)), 158, 1, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'147', N'Alambre Mellizo econom', CAST(1.50 AS Decimal(18, 2)), 151, 1, 1, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'148', N'Alambre solido de hebras N 14 INDECO m', CAST(2.00 AS Decimal(18, 2)), 74, 12, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'149', N'Alambre solido de hebras N 14 INDECO r', CAST(190.00 AS Decimal(18, 2)), 199, 12, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'15', N'"Clavo de acero de 4"""', CAST(0.50 AS Decimal(18, 2)), 136, 10, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'150', N'Adaptador de enchufe 3 a 2', CAST(2.00 AS Decimal(18, 2)), 67, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'151', N'Bruña de centro y canto Truper', CAST(12.00 AS Decimal(18, 2)), 15, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'152', N'Nivel de mano econom', CAST(12.00 AS Decimal(18, 2)), 1, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'153', N'Barilejo grande', CAST(8.00 AS Decimal(18, 2)), 106, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'154', N'Plancha Raspin', CAST(14.00 AS Decimal(18, 2)), 50, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'155', N'Plancha de pulir', CAST(14.00 AS Decimal(18, 2)), 170, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'156', N'Plancha de Batir', CAST(12.00 AS Decimal(18, 2)), 17, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'157', N'Espatula de 5 pulg', CAST(6.00 AS Decimal(18, 2)), 168, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'158', N'Espatula de 4 pulg', CAST(5.00 AS Decimal(18, 2)), 166, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'159', N'Espátula de 3 pulg', CAST(4.00 AS Decimal(18, 2)), 174, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'16', N'"Clavo de acero de 3"" (3u)"', CAST(1.00 AS Decimal(18, 2)), 42, 10, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'160', N'Espatula de 2 pulg', CAST(3.00 AS Decimal(18, 2)), 71, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'161', N'Disco Corte madera 7 1/2', CAST(18.00 AS Decimal(18, 2)), 116, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'162', N'Disco Corte madera 4 1/2', CAST(10.00 AS Decimal(18, 2)), 134, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'163', N'Disco Corte concreto 9', CAST(30.00 AS Decimal(18, 2)), 43, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'164', N'Disco Corte concreto 7 1/2', CAST(18.00 AS Decimal(18, 2)), 33, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'165', N'Disco Corte concreto 4 1/2', CAST(10.00 AS Decimal(18, 2)), 19, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'166', N'Disco Tronzadora metal 14', CAST(25.00 AS Decimal(18, 2)), 25, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'167', N'Disco corte metal 7 1/2-3M', CAST(9.00 AS Decimal(18, 2)), 106, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'168', N'Disco corte metal 4 1/2-3 M', CAST(5.00 AS Decimal(18, 2)), 154, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'169', N'Foco LED de 50 w', CAST(22.00 AS Decimal(18, 2)), 185, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'17', N'"Clavo de acero de 2 1/2"""', CAST(0.25 AS Decimal(18, 2)), 185, 10, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'170', N'Cintillos de 40 cm x 100 u', CAST(18.00 AS Decimal(18, 2)), 31, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'171', N'Brocha de 1 pulg', CAST(2.00 AS Decimal(18, 2)), 20, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'172', N'Lavaderos de fierro de 2 pozas', CAST(175.00 AS Decimal(18, 2)), 28, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'173', N'Lavaderos de fierro de 1 poza', CAST(75.00 AS Decimal(18, 2)), 138, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'174', N'Chapa cajón Econom', CAST(3.00 AS Decimal(18, 2)), 119, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'175', N'Chapa Cajon KOVA', CAST(6.00 AS Decimal(18, 2)), 31, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'176', N'Chapa Cajon Yale Original', CAST(25.00 AS Decimal(18, 2)), 129, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'177', N'Chapa Bola interior', CAST(18.00 AS Decimal(18, 2)), 24, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'178', N'Chapa Yale Barra', CAST(55.00 AS Decimal(18, 2)), 138, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'179', N'Chapa Yale pin', CAST(55.00 AS Decimal(18, 2)), 178, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'17EAZ', N'Example', CAST(1.00 AS Decimal(18, 2)), 200, 4, 1, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'18', N'"Clavo de acero de 2"""', CAST(0.20 AS Decimal(18, 2)), 168, 10, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'180', N'Chapa Travex pin 333', CAST(50.00 AS Decimal(18, 2)), 52, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'181', N'Tomacorriente triple s/p c/ psta tierra', CAST(6.00 AS Decimal(18, 2)), 117, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'182', N'Tomacorriente triple de s/p', CAST(5.00 AS Decimal(18, 2)), 97, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'183', N'Interruptor simple s/p', CAST(2.00 AS Decimal(18, 2)), 145, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'184', N'Tomacorriente simple de s/p', CAST(2.00 AS Decimal(18, 2)), 149, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'185', N'Sócate colgante', CAST(1.00 AS Decimal(18, 2)), 158, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'186', N'Sócate Ovalado p/ empotrado', CAST(4.00 AS Decimal(18, 2)), 128, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'187', N'Sócate para pared econ', CAST(3.00 AS Decimal(18, 2)), 171, 12, 2, 7, NULL)
GO
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'188', N'Tomacorriente c/ psta tierra Empot. Econ', CAST(6.00 AS Decimal(18, 2)), 173, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'189', N'Toma Inter mixto P/ Emp Econ', CAST(5.00 AS Decimal(18, 2)), 124, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'18EEEA4', N'NOMBRE', CAST(10.00 AS Decimal(18, 2)), 20, 7, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'19', N'"Clavo de acero de 1 1/2"" (6u)"', CAST(1.00 AS Decimal(18, 2)), 8, 10, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'190', N'Interruptor triple p/ empotrado Econ.', CAST(6.00 AS Decimal(18, 2)), 51, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'191', N'Enchufe Industrial', CAST(5.00 AS Decimal(18, 2)), 112, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'192', N'Enchufe Vision color', CAST(3.00 AS Decimal(18, 2)), 152, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'193', N'Enchufe negro econ.', CAST(1.00 AS Decimal(18, 2)), 176, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'194', N'Interruptor colgante', CAST(2.00 AS Decimal(18, 2)), 42, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'195', N'Rondana rectangular grande (mad)', CAST(1.00 AS Decimal(18, 2)), 84, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'196', N'Rondana redonda grande (mad)', CAST(1.00 AS Decimal(18, 2)), 12, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'197', N'Rondana redonda chica (mad)', CAST(0.50 AS Decimal(18, 2)), 181, 7, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'198', N'Tapas ciegas rectangulares', CAST(1.00 AS Decimal(18, 2)), 39, 12, 2, 7, CAST(N'2004-04-13' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'199', N'Tapas ciegas Redondas', CAST(1.00 AS Decimal(18, 2)), 169, 12, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'2', N'"Armella de 1/2"""', CAST(0.30 AS Decimal(18, 2)), 11, 7, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'20', N'"Clavo de acero de 1"""', CAST(0.10 AS Decimal(18, 2)), 178, 10, 1, 7, CAST(N'2011-07-11' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'200', N'Caja Para cuchillas 8 polos', CAST(18.00 AS Decimal(18, 2)), 152, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'201', N'Caja Para cuchillas 6 polos', CAST(16.00 AS Decimal(18, 2)), 52, 12, 2, 7, CAST(N'2023-06-21' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'202', N'Caja Para cuchillas 4 polos', CAST(14.00 AS Decimal(18, 2)), 195, 12, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'203', N'Foco LED de 60 w Tipo Plato', CAST(30.00 AS Decimal(18, 2)), 186, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'204', N'Foco LED de 50 w tipo plato', CAST(30.00 AS Decimal(18, 2)), 118, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'205', N'Foco LED de 28 w', CAST(15.00 AS Decimal(18, 2)), 144, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'206', N'Foco LED de 18w', CAST(12.00 AS Decimal(18, 2)), 51, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'207', N'Foco LED de 15 w', CAST(10.00 AS Decimal(18, 2)), 25, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'208', N'Foco LED de 9 w', CAST(7.00 AS Decimal(18, 2)), 115, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'209', N'Foco LED de 48 wats', CAST(20.00 AS Decimal(18, 2)), 107, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'21', N'"Lija para plato de 7"""', CAST(7.00 AS Decimal(18, 2)), 85, 5, 1, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'210', N'Interruptor doble de S/P', CAST(5.00 AS Decimal(18, 2)), 115, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'211', N'Interruptor doble p/ empotrado Econ.', CAST(5.00 AS Decimal(18, 2)), 171, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'212', N'Interruptor simplle p/ empotrado Econ.', CAST(4.00 AS Decimal(18, 2)), 169, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'213', N'Tomacorriente triple p/ empotrado Econ.', CAST(6.00 AS Decimal(18, 2)), 145, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'214', N'Tomacorriente doble p/ empotrado Econ.', CAST(5.00 AS Decimal(18, 2)), 133, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'215', N'Tomacorriente simple p/ empotrado Econ.', CAST(4.00 AS Decimal(18, 2)), 25, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'216', N'Abrazaderas para tubo de Luz 3/4', CAST(0.35 AS Decimal(18, 2)), 57, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'217', N'Caja Octagonal PVC Luz', CAST(1.00 AS Decimal(18, 2)), 180, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'218', N'Caja Rectangular PVC Luz', CAST(1.00 AS Decimal(18, 2)), 52, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'219', N'Curvas PVC de 3/4 Luz', CAST(0.60 AS Decimal(18, 2)), 44, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'22', N'"Lija para plato de 4"""', CAST(5.00 AS Decimal(18, 2)), 184, 5, 1, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'220', N'Tubo PVC de 3/4 Luz', CAST(4.50 AS Decimal(18, 2)), 126, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'221', N'Tubo PVC de 6 desagüe', CAST(130.00 AS Decimal(18, 2)), 138, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'222', N'Codo PVC de 3 desagüe', CAST(5.00 AS Decimal(18, 2)), 117, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'223', N'Tapón PCV de 2 desagüe', CAST(2.50 AS Decimal(18, 2)), 174, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'224', N'Reducciones PVC de 4 a 2 desagüe', CAST(5.00 AS Decimal(18, 2)), 140, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'225', N'Tapón PCV de 4 desagüe', CAST(4.00 AS Decimal(18, 2)), 163, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'226', N'Yee PVC de 2 desagüe', CAST(4.00 AS Decimal(18, 2)), 91, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'227', N'Tee PVC de 2 desagüe', CAST(4.00 AS Decimal(18, 2)), 160, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'228', N'Codo PVC de 2 x 45 desagüe', CAST(2.50 AS Decimal(18, 2)), 196, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'229', N'Codo PVC de 2 x 90 desagüe', CAST(2.50 AS Decimal(18, 2)), 28, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'23', N'Guantes de corte', CAST(8.00 AS Decimal(18, 2)), 8, 5, 2, 12, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'230', N'Yee PVC de 4 a 2 desagüe', CAST(8.00 AS Decimal(18, 2)), 86, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'231', N'Yee PVC de 4 x 4 desagüe', CAST(14.00 AS Decimal(18, 2)), 161, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'232', N'Tee PVC de 4 a 2 desagüe', CAST(8.00 AS Decimal(18, 2)), 172, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'233', N'Tee PVC de 4 x 4 desagüe', CAST(12.00 AS Decimal(18, 2)), 41, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'234', N'Codo PVC de 4 x 45 desagüe', CAST(8.00 AS Decimal(18, 2)), 43, 4, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'235', N'Codo PVC de 4 x 90 desagüe', CAST(8.00 AS Decimal(18, 2)), 101, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'236', N'Tubo PVC de 2 Nicoll desagüe', CAST(17.00 AS Decimal(18, 2)), 144, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'237', N'Tubo PVC de 3 Eurotubo desagüe', CAST(20.00 AS Decimal(18, 2)), 91, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'238', N'Tubo PVC de 4 Eurotubo desagüe', CAST(33.00 AS Decimal(18, 2)), 138, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'239', N'Tubo PVC de 4 marca Tubos lima', CAST(28.00 AS Decimal(18, 2)), 89, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'24', N'Guantes badana gruesa', CAST(10.00 AS Decimal(18, 2)), 25, 5, 2, 12, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'240', N'Univarsal PVC 3/4 agua', CAST(6.00 AS Decimal(18, 2)), 75, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'241', N'Llave de ganso resorte', CAST(35.00 AS Decimal(18, 2)), 27, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'242', N'Llave de ganso pesada', CAST(25.00 AS Decimal(18, 2)), 64, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'243', N'Llave de ganso econom', CAST(15.00 AS Decimal(18, 2)), 138, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'244', N'Cuello de cera con Guia', CAST(7.00 AS Decimal(18, 2)), 89, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'245', N'Registro de 4 pulg', CAST(12.00 AS Decimal(18, 2)), 122, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'246', N'Resumidero de 4 pulg', CAST(12.00 AS Decimal(18, 2)), 80, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'247', N'Rejilla con tapa de jebe 2 pulg', CAST(4.00 AS Decimal(18, 2)), 124, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'248', N'Registro de 2 pulg', CAST(4.00 AS Decimal(18, 2)), 107, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'249', N'Resumidero de 2 pulg', CAST(4.00 AS Decimal(18, 2)), 165, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'25', N'Guante de jebe', CAST(10.00 AS Decimal(18, 2)), 124, 5, 2, 12, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'250', N'Trampa flexible para una poza', CAST(15.00 AS Decimal(18, 2)), 100, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'251', N'Desaguadero de lavadero fierro', CAST(15.00 AS Decimal(18, 2)), 193, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'252', N'Trampa Gris de 2 pulg', CAST(8.00 AS Decimal(18, 2)), 19, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'253', N'Trampa blanca p/ Lav. fierro', CAST(8.00 AS Decimal(18, 2)), 170, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'254', N'Tampa Botella para lavadero', CAST(10.00 AS Decimal(18, 2)), 77, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'255', N'Accesorios de tanque agua', CAST(22.00 AS Decimal(18, 2)), 119, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'256', N'Valvula de salida SANI', CAST(7.00 AS Decimal(18, 2)), 60, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'257', N'Salida de ducha plástica agua', CAST(5.00 AS Decimal(18, 2)), 102, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'258', N'Salida de ducha metal agua', CAST(20.00 AS Decimal(18, 2)), 125, 4, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'259', N'Llave de lavadero pesado', CAST(25.00 AS Decimal(18, 2)), 168, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'26', N'Guantes de badana', CAST(10.00 AS Decimal(18, 2)), 50, 5, 2, 12, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'260', N'Llave de lavadero Liviano', CAST(15.00 AS Decimal(18, 2)), 132, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'261', N'Llave de ducha metal agua', CAST(25.00 AS Decimal(18, 2)), 116, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'262', N'Llave grifo de palanca PCP agua', CAST(18.00 AS Decimal(18, 2)), 52, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'263', N'Llave grifo Bronce agua', CAST(13.00 AS Decimal(18, 2)), 96, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'264', N'Llave Grifo de palanca roja pesada agua', CAST(12.00 AS Decimal(18, 2)), 118, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'265', N'Llave Grifo de palanca roja agua', CAST(10.00 AS Decimal(18, 2)), 68, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'266', N'Manguera de abastos 7/8 agua', CAST(8.00 AS Decimal(18, 2)), 132, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'267', N'Manguera de abastos 5/8 agua', CAST(8.00 AS Decimal(18, 2)), 49, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'268', N'Manguera de abastos 1/2 agua', CAST(8.00 AS Decimal(18, 2)), 62, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'269', N'Tee PVc de 3/4 agua', CAST(2.00 AS Decimal(18, 2)), 90, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'27', N'Balanza reloj', CAST(48.00 AS Decimal(18, 2)), 124, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'270', N'Codo PVC de 3/4 embone agua', CAST(2.00 AS Decimal(18, 2)), 72, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'271', N'Codo PVC de 3/4 con rosca agua', CAST(2.00 AS Decimal(18, 2)), 105, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'272', N'Reducciones PVC de 3/4 a 1/2 con rosca', CAST(2.00 AS Decimal(18, 2)), 62, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'273', N'Bushing PVC de 3/4 agua', CAST(3.00 AS Decimal(18, 2)), 41, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'274', N'Bushing PVC de 1/2 agua', CAST(2.50 AS Decimal(18, 2)), 129, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'275', N'Reduccions PVC de 3/4 x 1/2 agua', CAST(2.00 AS Decimal(18, 2)), 122, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'276', N'Codo PVC de 1/2 x 45 agua', CAST(1.50 AS Decimal(18, 2)), 21, 4, 2, 7, NULL)
GO
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'277', N'Llave de paso 1/2 agua', CAST(8.00 AS Decimal(18, 2)), 36, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'278', N'Universales 1/2 PVC agua', CAST(4.00 AS Decimal(18, 2)), 25, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'279', N'Niples PVC de 1/2 grandes agua', CAST(2.00 AS Decimal(18, 2)), 167, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'28', N'Balanza Electronica de 40 kg', CAST(150.00 AS Decimal(18, 2)), 63, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'280', N'Niples PVC de 1/2 chicos agua', CAST(1.50 AS Decimal(18, 2)), 27, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'281', N'Adaptadores PVC 1/2 agua', CAST(1.50 AS Decimal(18, 2)), 96, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'282', N'Unión PVC de 1/2 MIXTO agua', CAST(1.50 AS Decimal(18, 2)), 120, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'283', N'Unión PVC de 1/2 rosca agua', CAST(1.50 AS Decimal(18, 2)), 57, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'284', N'Unión PVC de 1/2 Embone agua', CAST(1.50 AS Decimal(18, 2)), 122, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'285', N'Tee PVC de 1/2 agua', CAST(1.50 AS Decimal(18, 2)), 181, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'286', N'Codo Cobre de 1/2 agua', CAST(4.00 AS Decimal(18, 2)), 10, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'287', N'Codo GALV de 1/2 agua', CAST(2.50 AS Decimal(18, 2)), 111, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'288', N'Codo PVC de 1/2 mixto agua', CAST(1.50 AS Decimal(18, 2)), 46, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'289', N'Codo PVC de 1/2 agua', CAST(1.50 AS Decimal(18, 2)), 2, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'29', N'"Autoperforantes de 1 1/2"""', CAST(0.20 AS Decimal(18, 2)), 168, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'290', N'Tubo PVC de 1 agua', CAST(18.00 AS Decimal(18, 2)), 80, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'291', N'Tubo PVC de 3/4 agua', CAST(15.00 AS Decimal(18, 2)), 103, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'292', N'Tubo PVC de 1/2 agua', CAST(12.00 AS Decimal(18, 2)), 37, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'293', N'Pintura de agua color y blanco', CAST(4.00 AS Decimal(18, 2)), 157, 3, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'294', N'Calaminon (030) 6m x 1.05m', CAST(137.00 AS Decimal(18, 2)), 84, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'295', N'Calamina transparente de 1.80 m', CAST(35.00 AS Decimal(18, 2)), 40, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'296', N'Calamina 014 x 3.60', CAST(24.00 AS Decimal(18, 2)), 117, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'297', N'Calamina 022 x 3.60', CAST(34.00 AS Decimal(18, 2)), 24, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'298', N'Celocia verda x 0.90m', CAST(4.00 AS Decimal(18, 2)), 109, 1, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'299', N'Celocia verde x 1.20m', CAST(5.00 AS Decimal(18, 2)), 3, 1, 1, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'3', N'Armella de 5/8', CAST(0.40 AS Decimal(18, 2)), 33, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'30', N'"Autoperforantes de 1"""', CAST(0.15 AS Decimal(18, 2)), 10, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'300', N'Malla Forrada verde de 1/2', CAST(6.00 AS Decimal(18, 2)), 76, 1, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'301', N'Malla Galv 1/2 gruesa', CAST(9.00 AS Decimal(18, 2)), 80, 1, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'302', N'Malla Galv de 1/2 econ', CAST(5.00 AS Decimal(18, 2)), 13, 1, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'303', N'Ballestas 0.75 x 10', CAST(34.00 AS Decimal(18, 2)), 13, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'304', N'Cuerda p/ puerta enrollable', CAST(8.00 AS Decimal(18, 2)), 197, 2, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'305', N'Cartera p/ puerta enrollable', CAST(15.00 AS Decimal(18, 2)), 75, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'306', N'Tambor p/ puerta enrollable', CAST(15.00 AS Decimal(18, 2)), 107, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'307', N'Regia T o Engranpe', CAST(100.00 AS Decimal(18, 2)), 28, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'308', N'Regla U', CAST(85.00 AS Decimal(18, 2)), 166, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'309', N'Plancha Negra 1/16 comercial', CAST(160.00 AS Decimal(18, 2)), 184, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'31', N'Perno Hexagonal de 1/4 x 4', CAST(0.60 AS Decimal(18, 2)), 78, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'310', N'Plancha Estrellada 2mm', CAST(250.00 AS Decimal(18, 2)), 75, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'311', N'Plancha Galv 1/32 Comercial', CAST(100.00 AS Decimal(18, 2)), 98, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'312', N'Plancha Galv 1/27 Comercial', CAST(110.00 AS Decimal(18, 2)), 103, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'313', N'Plancha Negra 1/32 Comercial', CAST(90.00 AS Decimal(18, 2)), 63, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'314', N'Plancha Negra 1/27 Comercial', CAST(100.00 AS Decimal(18, 2)), 92, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'315', N'Plancha Negra 1/20 Comercial', CAST(125.00 AS Decimal(18, 2)), 49, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'316', N'Platina de 2 x 1/8', CAST(40.00 AS Decimal(18, 2)), 169, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'317', N'Platina de 1/2 x 3/16', CAST(22.00 AS Decimal(18, 2)), 168, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'318', N'Platina de 1 x 1/8', CAST(22.00 AS Decimal(18, 2)), 107, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'319', N'Platina de 3/4 x 1/8', CAST(17.00 AS Decimal(18, 2)), 136, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'32', N'Perno Hexagonal de 1/4 x 3 1/2', CAST(0.60 AS Decimal(18, 2)), 82, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'320', N'Platina de 1/2 x 1/8', CAST(11.00 AS Decimal(18, 2)), 160, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'321', N'Fierro Redondo de 12mm (1/2)', CAST(34.00 AS Decimal(18, 2)), 199, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'322', N'Fierro Redondo de 3/8 (9mm)', CAST(22.00 AS Decimal(18, 2)), 90, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'323', N'Fierro Cuadrado de 12mm (1/2)', CAST(34.00 AS Decimal(18, 2)), 95, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'324', N'Fierro Cuadrado de 3/8', CAST(22.00 AS Decimal(18, 2)), 86, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'325', N'Tee de 3/4', CAST(30.00 AS Decimal(18, 2)), 62, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'326', N'Tee de 1 x 1/8', CAST(37.00 AS Decimal(18, 2)), 43, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'327', N'Angulo de 3/4 x 2mm', CAST(20.00 AS Decimal(18, 2)), 198, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'328', N'Angulo de 1 x 1/8', CAST(35.00 AS Decimal(18, 2)), 97, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'329', N'Angulo de 1 x 2.5mm', CAST(29.00 AS Decimal(18, 2)), 138, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'33', N'Perno Hexagonal de 1/4 x 2 1/2', CAST(0.50 AS Decimal(18, 2)), 90, 7, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'330', N'Angulo de 1 x 2mm', CAST(25.00 AS Decimal(18, 2)), 119, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'331', N'Angulo de 1 1/4 x 1/8', CAST(42.00 AS Decimal(18, 2)), 175, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'332', N'Angulo de 1 1/2 x 1/8', CAST(55.00 AS Decimal(18, 2)), 151, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'333', N'Tubo Rectangular 2 x 1 x 0.9', CAST(33.00 AS Decimal(18, 2)), 150, 2, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'334', N'Tubo Rectangular 2 x 1 x 1.5mm', CAST(55.00 AS Decimal(18, 2)), 98, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'335', N'Tubo Rectangular 40 x 60 x 1.5mm', CAST(73.00 AS Decimal(18, 2)), 35, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'336', N'Tubo Rectangular 40 x 60 x 2mm', CAST(100.00 AS Decimal(18, 2)), 132, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'337', N'Tubo Rectangular 40 x 80  x 1.5mm', CAST(90.00 AS Decimal(18, 2)), 19, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'338', N'Tubo Rectangular 40 x 80 x 2mm', CAST(125.00 AS Decimal(18, 2)), 168, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'339', N'Tubo Rectangular de 4 x 2 x 2mm', CAST(190.00 AS Decimal(18, 2)), 59, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'34', N'Perno Hexagonal de 1/4 x 2', CAST(0.50 AS Decimal(18, 2)), 2, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'340', N'Tubo Cuadrado de 3/4 x 1.2mm', CAST(25.00 AS Decimal(18, 2)), 12, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'341', N'Tubo Cuadrado de 3/4 x 1.5mm', CAST(32.00 AS Decimal(18, 2)), 136, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'342', N'Tubo Cuadrado de 1 x 0.9', CAST(27.00 AS Decimal(18, 2)), 92, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'343', N'Tubo Cuadrado de 1 x 1.2mm', CAST(33.00 AS Decimal(18, 2)), 79, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'344', N'Tubo Cuadrado de 1 x 1.5mm', CAST(40.00 AS Decimal(18, 2)), 33, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'345', N'Tubo Cuadrado de 1 1/4 x 1.5mm', CAST(50.00 AS Decimal(18, 2)), 185, 2, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'346', N'Tubo Cuadrado de 1 1/2 x 1.5mm', CAST(55.00 AS Decimal(18, 2)), 82, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'347', N'Tubo Cuadrado de 2 x 2mm', CAST(100.00 AS Decimal(18, 2)), 25, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'348', N'Tubo Redondo de 1/2 x 2mm', CAST(35.00 AS Decimal(18, 2)), 143, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'349', N'Tubo Redondo de 3/4 x 2mm', CAST(45.00 AS Decimal(18, 2)), 23, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'35', N'Perno Hexagonal de 1/4 x 1 1/2', CAST(0.50 AS Decimal(18, 2)), 26, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'350', N'Tubo Redondo de 1 x 2mm', CAST(55.00 AS Decimal(18, 2)), 69, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'351', N'Tubo Redondo de 1 1/4 x 2mm', CAST(65.00 AS Decimal(18, 2)), 73, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'352', N'Tubo Redondo de de 1 1/2 x 2mm', CAST(75.00 AS Decimal(18, 2)), 120, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'353', N'Tubo Redondo de 2 x 2mm', CAST(95.00 AS Decimal(18, 2)), 117, 2, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'354', N'Escobilla de baño', CAST(6.00 AS Decimal(18, 2)), 65, 9, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'355', N'Tirabuzón para baño', CAST(6.00 AS Decimal(18, 2)), 113, 9, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'356', N'Fragua color', CAST(6.00 AS Decimal(18, 2)), 115, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'357', N'Talco Americano', CAST(3.50 AS Decimal(18, 2)), 162, 3, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'358', N'Tiza o merluza', CAST(2.00 AS Decimal(18, 2)), 67, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'359', N'Kola Tekno verde x kilo', CAST(14.00 AS Decimal(18, 2)), 55, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'36', N'Perno Hexagonal de 1/4 x 1', CAST(0.50 AS Decimal(18, 2)), 140, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'360', N'Kola Tekno verde', CAST(50.00 AS Decimal(18, 2)), 9, 3, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'361', N'Quitasarro', CAST(5.00 AS Decimal(18, 2)), 128, 9, 2, 4, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'362', N'Kresso', CAST(7.00 AS Decimal(18, 2)), 38, 9, 2, 4, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'363', N'Soda caustica liquida', CAST(8.00 AS Decimal(18, 2)), 98, 9, 2, 4, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'364', N'Acido Muriatico', CAST(7.00 AS Decimal(18, 2)), 152, 9, 2, 4, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'365', N'Manguera para agua', CAST(1.50 AS Decimal(18, 2)), 16, 4, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'366', N'Manguera de Nivel', CAST(1.00 AS Decimal(18, 2)), 17, 1, 1, 5, NULL)
GO
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'367', N'Preservante de madera', CAST(20.00 AS Decimal(18, 2)), 69, 3, 2, 4, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'368', N'Aguarras', CAST(9.00 AS Decimal(18, 2)), 200, 3, 2, 6, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'369', N'Thiner Acrilico', CAST(9.00 AS Decimal(18, 2)), 192, 3, 1, 6, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'37', N'Perno Hexagonal de 1/4 x 3/4', CAST(0.50 AS Decimal(18, 2)), 117, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'370', N'Gln Thiner Acrilico 305', CAST(24.00 AS Decimal(18, 2)), 163, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'371', N'Base Gris 1/4', CAST(20.00 AS Decimal(18, 2)), 198, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'372', N'Base Gris al aceite', CAST(70.00 AS Decimal(18, 2)), 52, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'373', N'Base Zincromato 1/4', CAST(16.00 AS Decimal(18, 2)), 40, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'374', N'Base Zincromato Maestro', CAST(58.00 AS Decimal(18, 2)), 56, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'375', N'Anticorrosivo Maestro', CAST(55.00 AS Decimal(18, 2)), 14, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'376', N'Anticorrosivo Koral', CAST(42.00 AS Decimal(18, 2)), 77, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'377', N'Esmalte sintético CPP', CAST(55.00 AS Decimal(18, 2)), 100, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'378', N'Laca Selladora 1/4', CAST(20.00 AS Decimal(18, 2)), 187, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'379', N'Laca Selladora Paracas', CAST(68.00 AS Decimal(18, 2)), 123, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'38', N'Extension de alambre vulc. x 20m', CAST(40.00 AS Decimal(18, 2)), 89, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'380', N'Laca a la piroxilina 1/4', CAST(20.00 AS Decimal(18, 2)), 89, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'381', N'Laca a la Piroxilina', CAST(70.00 AS Decimal(18, 2)), 95, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'382', N'Gloss Acrilico 1/4', CAST(21.00 AS Decimal(18, 2)), 61, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'383', N'Gloss Acrilico', CAST(80.00 AS Decimal(18, 2)), 117, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'384', N'Esmalte Sintético 1/4', CAST(16.00 AS Decimal(18, 2)), 127, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'385', N'Esmalte Sintético Económico', CAST(42.00 AS Decimal(18, 2)), 191, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'386', N'LATEX CPP', CAST(40.00 AS Decimal(18, 2)), 158, 3, 2, 9, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'387', N'LATEX FAST', CAST(28.00 AS Decimal(18, 2)), 92, 3, 2, 9, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'388', N'Sellador CPP Blanco', CAST(35.00 AS Decimal(18, 2)), 118, 3, 2, 9, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'389', N'Temple fino sinolif CPP x 5kg', CAST(18.00 AS Decimal(18, 2)), 154, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'39', N'Extension de alambre vulc. x 10m', CAST(30.00 AS Decimal(18, 2)), 79, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'390', N'Temple fino sinolif CPP x 25kg', CAST(62.00 AS Decimal(18, 2)), 17, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'391', N'Temple pato x 25kg', CAST(35.00 AS Decimal(18, 2)), 99, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'392', N'Alambre de cerco 200mt', CAST(70.00 AS Decimal(18, 2)), 198, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'393', N'Grapas de cerco', CAST(10.00 AS Decimal(18, 2)), 95, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'394', N'Clavos de calamina', CAST(10.00 AS Decimal(18, 2)), 158, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'395', N'Clavos de 6 pulg', CAST(0.33 AS Decimal(18, 2)), 54, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'396', N'Clavos de 3 s/c', CAST(12.00 AS Decimal(18, 2)), 149, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'397', N'Clavos de 2 s/c', CAST(12.00 AS Decimal(18, 2)), 89, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'398', N'Clavos de 1 1/2 s/c', CAST(12.00 AS Decimal(18, 2)), 158, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'399', N'Clavos de 1 1/2 c/c', CAST(12.00 AS Decimal(18, 2)), 112, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'4', N'"Armella de 1"""', CAST(0.40 AS Decimal(18, 2)), 94, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'40', N'Extension de alambre vulc. x 5m', CAST(20.00 AS Decimal(18, 2)), 115, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'400', N'Clavos de1 s/c', CAST(12.00 AS Decimal(18, 2)), 34, 10, 1, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'401', N'Clavos de 1 c/c', CAST(12.00 AS Decimal(18, 2)), 76, 10, 1, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'402', N'Clavos de 3/4 s/c', CAST(12.00 AS Decimal(18, 2)), 44, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'403', N'Clavos de 3/4 c/c', CAST(12.00 AS Decimal(18, 2)), 45, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'404', N'Clavo de 4 c/c', CAST(7.00 AS Decimal(18, 2)), 33, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'405', N'Clavos de 2 c/c', CAST(7.00 AS Decimal(18, 2)), 59, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'406', N'Clavos de 2 1/2 c/c', CAST(7.00 AS Decimal(18, 2)), 73, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'407', N'Clavos de 3 c/c', CAST(7.00 AS Decimal(18, 2)), 73, 10, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'408', N'Alambre de construccion N 08', CAST(6.00 AS Decimal(18, 2)), 48, 1, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'409', N'Alambre de construccion N 16', CAST(6.00 AS Decimal(18, 2)), 173, 1, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'41', N'Tapón PVC de 1/2 embone', CAST(1.00 AS Decimal(18, 2)), 165, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'410', N'Yeso chica', CAST(3.50 AS Decimal(18, 2)), 124, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'411', N'Yeso x 40kg', CAST(17.00 AS Decimal(18, 2)), 33, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'412', N'Cal', CAST(17.00 AS Decimal(18, 2)), 79, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'413', N'Pegamento para porcelanato SIKAN', CAST(25.00 AS Decimal(18, 2)), 130, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'414', N'Pegamento para ceramica Celima', CAST(15.00 AS Decimal(18, 2)), 179, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'415', N'Fierro Corrugado de 5/8', CAST(65.00 AS Decimal(18, 2)), 81, 1, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'416', N'Fierro Currado de N 08', CAST(18.00 AS Decimal(18, 2)), 3, 1, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'417', N'Fierro Currado de 1/4', CAST(10.00 AS Decimal(18, 2)), 135, 1, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'418', N'Fierro Currado de 3/8', CAST(23.00 AS Decimal(18, 2)), 64, 1, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'419', N'Fierro Corrugado de 12mm', CAST(36.00 AS Decimal(18, 2)), 173, 1, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'42', N'Tapón PVC de 1/2 Hembra', CAST(1.00 AS Decimal(18, 2)), 115, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'420', N'Fierro Corrugado de 1/2', CAST(39.00 AS Decimal(18, 2)), 114, 1, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'421', N'Cemento Antisalitre Mochica', CAST(32.50 AS Decimal(18, 2)), 174, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'422', N'Cemento Extraforte Mochica', CAST(30.00 AS Decimal(18, 2)), 123, 1, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'43', N'Tapón PVC de 1/2 macho', CAST(1.00 AS Decimal(18, 2)), 23, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'436', N'PRODUCTO DE PRUEBA AC', CAST(10.50 AS Decimal(18, 2)), 35, 1, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'438', N'PRODUCTO', CAST(20.00 AS Decimal(18, 2)), 55, 2, 2, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'439', N'NOMBREEE', CAST(1.00 AS Decimal(18, 2)), 50, 1, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'44', N'Llave de paso PVC 3/4', CAST(9.00 AS Decimal(18, 2)), 40, 4, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'45', N'Union PVC 3/4 mixto', CAST(2.00 AS Decimal(18, 2)), 32, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'46', N'Plastico azul grueso', CAST(10.00 AS Decimal(18, 2)), 162, 4, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'47', N'Malla rache tupida', CAST(15.00 AS Decimal(18, 2)), 40, 1, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'48', N'Gln Thiner Acrilico 905', CAST(35.00 AS Decimal(18, 2)), 59, 9, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'4815AE', N'PRODUCTO SIN FV ', CAST(10.20 AS Decimal(18, 2)), 100, 3, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'49', N'Perno cabeza de coche 1/4 x 1 1/2', CAST(0.50 AS Decimal(18, 2)), 16, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'5', N'"Armella de 1 1/4"""', CAST(0.50 AS Decimal(18, 2)), 78, 7, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'50', N'Perno cabeza de coche 1/4 x 1', CAST(0.50 AS Decimal(18, 2)), 33, 7, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'51', N'Pegamento oatey PVC transparente 1/4', CAST(40.00 AS Decimal(18, 2)), 53, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'52', N'Pegamento PVC amarillo mediano', CAST(3.50 AS Decimal(18, 2)), 25, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'53', N'Pegamento PVC amarillo pequeño', CAST(1.00 AS Decimal(18, 2)), 59, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'54', N'Pegamento oatey pequeño', CAST(5.00 AS Decimal(18, 2)), 20, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'548EA1', N'PRODUCTON CON FV', CAST(10.00 AS Decimal(18, 2)), 100, 3, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'55', N'Pegamento oatey de 1/32 azul', CAST(12.00 AS Decimal(18, 2)), 75, 4, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'56', N'Pegamento oatey de 1/32 transparente', CAST(10.00 AS Decimal(18, 2)), 163, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'57', N'Llaves Allen', CAST(15.00 AS Decimal(18, 2)), 58, 6, 2, 11, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'58', N'Bornes de bateria', CAST(6.00 AS Decimal(18, 2)), 68, 5, 2, 11, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'59', N'Plato lija de 7 para mola', CAST(14.00 AS Decimal(18, 2)), 4, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'6', N'"Armella de 1 1/2"""', CAST(0.51 AS Decimal(18, 2)), 1, 7, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'60', N'Plato lija de 4 para mola ', CAST(10.00 AS Decimal(18, 2)), 21, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'61', N'Africano 1/16', CAST(5.00 AS Decimal(18, 2)), 175, 8, 2, 7, CAST(N'2024-11-12' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'62', N'Africano de 1/4', CAST(19.00 AS Decimal(18, 2)), 170, 8, 2, 7, CAST(N'2023-04-13' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'63', N'Llanta de carretilla con aro TRUPER', CAST(70.00 AS Decimal(18, 2)), 109, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'64', N'Llanta de carretilla sin aro', CAST(30.00 AS Decimal(18, 2)), 98, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'65', N'Tanque Eternit x 1,100 Litros', CAST(600.00 AS Decimal(18, 2)), 75, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'66', N'Tanque NICOLL x 600 Litros', CAST(550.00 AS Decimal(18, 2)), 22, 4, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'67', N'Tanque NICOLL x 1,100 Litros ', CAST(650.00 AS Decimal(18, 2)), 136, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'68', N'Gloss Acrilico 1/16', CAST(6.00 AS Decimal(18, 2)), 46, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'69', N'Gloss Acrilico 1/8', CAST(11.00 AS Decimal(18, 2)), 170, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'7', N'"Armella de 2"""', CAST(1.00 AS Decimal(18, 2)), 113, 7, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'70', N'Temple PATO x 5kg', CAST(12.00 AS Decimal(18, 2)), 80, 3, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'71', N'Temple PATO x 25kg', CAST(35.00 AS Decimal(18, 2)), 143, 3, 2, 2, NULL)
GO
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'72', N'Kola tekno Clasica', CAST(46.00 AS Decimal(18, 2)), 68, 3, 2, 9, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'73', N'Barniz transparente paracas ', CAST(80.00 AS Decimal(18, 2)), 125, 3, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'74', N'"Tubo Pvc de 4"" PAVCO"', CAST(35.00 AS Decimal(18, 2)), 114, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'75', N'"Tubo pvc de 2"" desague econom"', CAST(10.00 AS Decimal(18, 2)), 160, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'76', N'"Abrazadera para agua de 2"" a 1/2 consisa"', CAST(20.00 AS Decimal(18, 2)), 160, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'77', N'Boya para tanque', CAST(40.00 AS Decimal(18, 2)), 186, 4, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'78', N'Foco LED estrella de 30 w', CAST(15.00 AS Decimal(18, 2)), 184, 12, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'79', N'Tubo cuadrado 3/4 x 0.9 mm', CAST(20.00 AS Decimal(18, 2)), 106, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'8', N'Pegamento para PVC NICOLL Azul', CAST(12.00 AS Decimal(18, 2)), 183, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'80', N'candado N 75 mm', CAST(18.00 AS Decimal(18, 2)), 66, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'81', N'Bisagras de pin 4 x 3/8', CAST(2.50 AS Decimal(18, 2)), 131, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'82', N'Bisagras de pin 4 x 1/2', CAST(3.00 AS Decimal(18, 2)), 103, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'83', N'Garruchas x4 u', CAST(20.00 AS Decimal(18, 2)), 19, 5, 2, 11, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'84', N'Punta con mango ', CAST(12.00 AS Decimal(18, 2)), 56, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'85', N'Martillo Truper', CAST(30.00 AS Decimal(18, 2)), 43, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'86', N'Comba de 4 Lb Truper', CAST(35.00 AS Decimal(18, 2)), 129, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'87', N'Zapapico sin mango', CAST(35.00 AS Decimal(18, 2)), 64, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'88', N'Tortol de fierro', CAST(6.00 AS Decimal(18, 2)), 59, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'89', N'Trampa para doblar fierro', CAST(15.00 AS Decimal(18, 2)), 190, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'9', N'Pegamento para PVC NICOLL Transparente', CAST(10.00 AS Decimal(18, 2)), 43, 4, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'90', N'Cincel de fierro', CAST(6.00 AS Decimal(18, 2)), 159, 5, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'91', N'Cizaya de 18 pulg', CAST(40.00 AS Decimal(18, 2)), 166, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'92', N'Cizaya de 14 pulg', CAST(35.00 AS Decimal(18, 2)), 1, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'93', N'Garruchas grande x 4 u', CAST(30.00 AS Decimal(18, 2)), 69, 5, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'94', N'Garruchas con freno x4u', CAST(25.00 AS Decimal(18, 2)), 2, 5, 2, 2, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'95', N'Pistola para pintar Truper', CAST(70.00 AS Decimal(18, 2)), 189, 3, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'96', N'Esmeriladora Angular 4 1/2 BD', CAST(120.00 AS Decimal(18, 2)), 100, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'97', N'Kit de puerta', CAST(20.00 AS Decimal(18, 2)), 29, 6, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'98', N'Kit de regla o postigo', CAST(20.00 AS Decimal(18, 2)), 150, 5, 2, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'99', N'Bisagra tijera', CAST(1.50 AS Decimal(18, 2)), 141, 6, 1, 7, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'EA4CA', N'PRODUCTO SIN FN', CAST(10.20 AS Decimal(18, 2)), 10, 2, 2, 4, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'EAC178AC1', N'PRODUCTO CON FV 2', CAST(10.20 AS Decimal(18, 2)), 10, 1, 1, 1, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'EAX1EEA', N'PRODUCTO CON FV', CAST(100.00 AS Decimal(18, 2)), 10, 4, 2, 8, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'EBAE15', N'PRODUCTOOO SIN FV', CAST(10.00 AS Decimal(18, 2)), 209, 5, 2, 2, CAST(N'2023-06-24' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'N7EVA99', N'NUEVO CON FV', CAST(10.00 AS Decimal(18, 2)), 100, 3, 2, 5, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'NU4AC', N'NUEVOOO CON FV', CAST(100.00 AS Decimal(18, 2)), 208, 3, 1, 3, CAST(N'2023-06-27' AS Date))
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'NU7EPO75', N'SIN FV DE VERDAD', CAST(10.80 AS Decimal(18, 2)), 100, 2, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'NU7EVO', N'NUEVO SIN FV', CAST(10.00 AS Decimal(18, 2)), 100, 2, 2, 3, NULL)
INSERT [dbo].[products] ([id], [name], [price], [stock], [area_id], [status_id], [products_type_id], [expiration_date]) VALUES (N'PDNXEA', N'PRODUCTO CON F.V', CAST(10.50 AS Decimal(18, 2)), 100, 10, 1, 8, NULL)
GO
SET IDENTITY_INSERT [dbo].[products_types] ON 

INSERT [dbo].[products_types] ([id], [type]) VALUES (1, N'KILOGRAMO')
INSERT [dbo].[products_types] ([id], [type]) VALUES (2, N'BOLSA ')
INSERT [dbo].[products_types] ([id], [type]) VALUES (3, N'VARILLA')
INSERT [dbo].[products_types] ([id], [type]) VALUES (4, N'BOTELLA')
INSERT [dbo].[products_types] ([id], [type]) VALUES (5, N'METRO')
INSERT [dbo].[products_types] ([id], [type]) VALUES (6, N'LITRO')
INSERT [dbo].[products_types] ([id], [type]) VALUES (7, N'UNIDAD')
INSERT [dbo].[products_types] ([id], [type]) VALUES (8, N'Galón')
INSERT [dbo].[products_types] ([id], [type]) VALUES (9, N'Balde')
INSERT [dbo].[products_types] ([id], [type]) VALUES (10, N'Rollo')
INSERT [dbo].[products_types] ([id], [type]) VALUES (11, N'Juego')
INSERT [dbo].[products_types] ([id], [type]) VALUES (12, N'Par')
SET IDENTITY_INSERT [dbo].[products_types] OFF
GO
SET IDENTITY_INSERT [dbo].[sales] ON 

INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (3, CAST(N'2023-05-17T19:45:13.220' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (4, CAST(N'2023-06-15T20:17:41.157' AS DateTime), 12, N'CATERYN YULIXA ALVAREZ LUNA', N'41227730')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (5, CAST(N'2023-02-17T20:07:45.183' AS DateTime), 12, N'ANDRE KALED ADRIANZEN CORDOVA', N'71488964')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (6, CAST(N'2023-02-17T20:11:57.937' AS DateTime), 12, N'ANDRE KALED ADRIANZEN CORDOVA', N'71488964')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (7, CAST(N'2023-04-17T20:11:18.233' AS DateTime), 12, N'ANDRE KALED ADRIANZEN CORDOVA', N'71488964')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (8, CAST(N'2023-01-17T20:11:52.567' AS DateTime), 12, N'CATERYN YULIXA ALVAREZ LUNA', N'41227730')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (9, CAST(N'2023-02-17T20:07:50.843' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (10, CAST(N'2023-06-15T20:30:23.137' AS DateTime), 12, N'DANA MILENE RAMOS ESPINOZA', N'75958292')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (11, CAST(N'2023-06-15T20:30:41.190' AS DateTime), 12, N'JORGE ENRIQUE ADRIANZEN CORDOVA', N'71488963')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (12, CAST(N'2023-06-15T20:31:44.920' AS DateTime), 12, N'LILIA NEIDALI MONDRAGON CORDOVA', N'62766485')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (13, CAST(N'2022-11-17T20:30:02.813' AS DateTime), 12, N'LILIA NEIDALI MONDRAGON CORDOVA', N'62766485')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (14, CAST(N'2023-06-15T20:32:28.740' AS DateTime), 12, N'LILIA NEIDALI MONDRAGON CORDOVA', N'62766485')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (15, CAST(N'2023-06-15T20:34:42.690' AS DateTime), 12, N'PIERO ALEXANDRO RUIZ RUIZ', N'71089476')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (16, CAST(N'2023-06-15T20:34:58.120' AS DateTime), 12, N'PIERO ALEXANDRO RUIZ RUIZ', N'71089476')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (17, CAST(N'2022-12-17T20:30:25.507' AS DateTime), 12, N'PIERO ALEXANDRO RUIZ RUIZ', N'71089476')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (18, CAST(N'2023-06-15T20:38:32.587' AS DateTime), 12, N'BRANDON ALLAN SAGASTEGUI HERRADA', N'73122219')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (19, CAST(N'2023-03-18T01:24:12.963' AS DateTime), 12, N'BRANDON ALLAN SAGASTEGUI HERRADA', N'73122219')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (20, CAST(N'2023-06-15T20:40:01.727' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (21, CAST(N'2023-06-15T20:41:48.667' AS DateTime), 12, N'IRVIN JHONATAN CIPRA GARCIA', N'75958296')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (22, CAST(N'2023-06-15T20:43:16.677' AS DateTime), 12, N'ANDRE KALED ADRIANZEN CORDOVA', N'71488964')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (23, CAST(N'2023-06-15T20:43:30.487' AS DateTime), 12, N'PIERO ALEXANDRO RUIZ RUIZ', N'71089476')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (24, CAST(N'2023-06-15T20:43:48.393' AS DateTime), 12, N'JORGE ENRIQUE ADRIANZEN CORDOVA', N'71488963')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (25, CAST(N'2023-06-15T20:44:08.700' AS DateTime), 12, N'CATERYN YULIXA ALVAREZ LUNA', N'41227730')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (26, CAST(N'2023-06-15T20:44:32.763' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (27, CAST(N'2023-06-15T21:06:34.007' AS DateTime), 12, N'JHONATAN HASAEL CALLE MACHACUAY', N'72433828')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (28, CAST(N'2023-06-15T21:06:49.003' AS DateTime), 12, N'JHONATAN HASAEL CALLE MACHACUAY', N'72433828')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (29, CAST(N'2023-04-17T20:11:15.893' AS DateTime), 12, N'VICTOR MANUEL CERCADO RUESTA', N'73299470')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (30, CAST(N'2023-06-15T21:16:50.997' AS DateTime), 12, N'VICTOR MANUEL CERCADO RUESTA', N'73299470')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (31, CAST(N'2023-06-15T21:17:05.597' AS DateTime), 12, N'VICTOR MANUEL CERCADO RUESTA', N'73299470')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (32, CAST(N'2023-04-17T20:08:26.493' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (33, CAST(N'2023-06-16T16:00:03.230' AS DateTime), 12, N'LILIA NEIDALI MONDRAGON CORDOVA', N'62766485')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (34, CAST(N'2023-03-18T01:23:59.467' AS DateTime), 12, N'BRANDON ALLAN SAGASTEGUI HERRADA', N'73122219')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (35, CAST(N'2023-04-17T20:11:13.120' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (36, CAST(N'2023-06-17T03:28:30.397' AS DateTime), 12, N'ANDRE KALED ADRIANZEN CORDOVA', N'71488964')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (37, CAST(N'2023-06-17T07:16:06.553' AS DateTime), 12, N'BRANDON ALLAN SAGASTEGUI HERRADA', N'73122219')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (38, CAST(N'2023-06-17T07:16:25.963' AS DateTime), 12, N'CATERYN YULIXA ALVAREZ LUNA', N'41227730')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (39, CAST(N'2023-04-17T20:11:14.263' AS DateTime), 12, N'BRANDON ALLAN SAGASTEGUI HERRADA', N'73122219')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (40, CAST(N'2023-06-17T07:17:24.500' AS DateTime), 12, N'VICTOR MANUEL CERCADO RUESTA', N'73299470')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (41, CAST(N'2023-06-18T16:22:44.207' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (42, CAST(N'2023-06-19T00:00:14.817' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (43, CAST(N'2023-06-20T03:31:17.320' AS DateTime), 12, N'FRANZ SCHWARTZ GAVINO CARRERA', N'75139821')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (45, CAST(N'2023-06-20T19:08:25.547' AS DateTime), 12, N'LILIA NEIDALI MONDRAGON CORDOVA', N'62766485')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (46, CAST(N'2023-06-20T19:09:28.557' AS DateTime), 12, N'LESLIE TATIANA WONG YARLEQUE', N'74812329')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (47, CAST(N'2023-06-20T19:20:52.253' AS DateTime), 12, N'RUBY DONNA VILLASECA NUÑEZ', N'73337809')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (48, CAST(N'2023-06-21T20:05:20.497' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (49, CAST(N'2023-06-22T04:45:20.930' AS DateTime), 12, N'ANDRE KALED ADRIANZEN CORDOVA', N'71488964')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (50, CAST(N'2023-06-24T00:41:07.667' AS DateTime), 12, N'MARIA ISABEL BUENO RODRIGUEZ', N'72233838')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (51, CAST(N'2023-06-24T15:55:20.297' AS DateTime), 12, N'KEVIN OREALY CESPEDES ALVAREZ', N'75958291')
INSERT [dbo].[sales] ([id], [date], [users_id], [customer], [dni]) VALUES (52, CAST(N'2023-06-24T16:45:19.023' AS DateTime), 12, N'YOSSI MARGOT GARCIA PEREZ', N'22274826')
SET IDENTITY_INSERT [dbo].[sales] OFF
GO
SET IDENTITY_INSERT [dbo].[sales_details] ON 

INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (151, N'107', 3, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (152, N'106', 4, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (153, N'158', 5, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (154, N'114', 6, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (155, N'118', 7, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (156, N'134', 8, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (157, N'17', 9, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (158, N'131', 10, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (159, N'115', 11, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (160, N'107', 12, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (161, N'295', 13, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (162, N'106', 14, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (163, N'109', 15, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (164, N'17', 16, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (165, N'129', 17, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (166, N'85', 18, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (167, N'15', 18, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (168, N'294', 18, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (169, N'102', 19, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (170, N'394', 20, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (171, N'136', 21, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (172, N'135', 22, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (173, N'135', 23, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (174, N'106', 24, 12)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (175, N'111', 25, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (176, N'294', 26, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (177, N'129', 27, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (178, N'15', 28, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (179, N'140', 29, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (180, N'174', 30, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (181, N'168', 31, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (182, N'161', 32, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (183, N'145', 33, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (184, N'294', 34, 3)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (185, N'15', 34, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (186, N'151', 35, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (187, N'141', 36, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (188, N'130', 37, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (189, N'105', 38, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (190, N'294', 39, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (191, N'106', 40, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (192, N'122', 41, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (193, N'294', 42, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (194, N'15', 42, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (195, N'106', 43, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (197, N'105', 45, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (198, N'104', 46, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (199, N'19', 47, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (200, N'294', 47, 2)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (201, N'108', 48, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (202, N'104', 49, 35)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (203, N'106', 50, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (204, N'118', 50, 20)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (205, N'112', 51, 1)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (206, N'294', 52, 5)
INSERT [dbo].[sales_details] ([id], [producto_id], [sales_id], [quantity]) VALUES (207, N'105', 52, 1)
SET IDENTITY_INSERT [dbo].[sales_details] OFF
GO
INSERT [dbo].[security] ([token], [user_id]) VALUES (NULL, 12)
GO
INSERT [dbo].[status] ([id], [active]) VALUES (1, 0)
INSERT [dbo].[status] ([id], [active]) VALUES (2, 1)
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [username], [email], [password]) VALUES (12, N'ferreteria', N'ferreteriajr267@gmail.com', N'$2b$10$6piYDb5mIl/So.Bg056bxOCz1jV9JFbY/0VZslysrWwsbFoT8vDgy')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[sales] ADD  CONSTRAINT [DF_sales_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[sales] ADD  CONSTRAINT [DF_ventas_cliente]  DEFAULT ('CLIENTE') FOR [customer]
GO
ALTER TABLE [dbo].[sales] ADD  CONSTRAINT [DF_ventas_dni]  DEFAULT ((0)) FOR [dni]
GO
ALTER TABLE [dbo].[status] ADD  CONSTRAINT [DF_areas_estado_activo]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[areas]  WITH CHECK ADD  CONSTRAINT [FK_areas_status1] FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[areas] CHECK CONSTRAINT [FK_areas_status1]
GO
ALTER TABLE [dbo].[pdfs]  WITH CHECK ADD  CONSTRAINT [FK_pdfs_sales] FOREIGN KEY([sales_id])
REFERENCES [dbo].[sales] ([id])
GO
ALTER TABLE [dbo].[pdfs] CHECK CONSTRAINT [FK_pdfs_sales]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_areas] FOREIGN KEY([area_id])
REFERENCES [dbo].[areas] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_areas]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_products_types] FOREIGN KEY([products_type_id])
REFERENCES [dbo].[products_types] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_products_types]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_status] FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_status]
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [FK_ventas_usuarios] FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [FK_ventas_usuarios]
GO
ALTER TABLE [dbo].[sales_details]  WITH CHECK ADD  CONSTRAINT [FK_venta_detalles_productos] FOREIGN KEY([producto_id])
REFERENCES [dbo].[products] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[sales_details] CHECK CONSTRAINT [FK_venta_detalles_productos]
GO
ALTER TABLE [dbo].[sales_details]  WITH CHECK ADD  CONSTRAINT [FK_venta_detalles_ventas] FOREIGN KEY([sales_id])
REFERENCES [dbo].[sales] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_details] CHECK CONSTRAINT [FK_venta_detalles_ventas]
GO
ALTER TABLE [dbo].[security]  WITH CHECK ADD  CONSTRAINT [FK_security_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[security] CHECK CONSTRAINT [FK_security_users]
GO
/****** Object:  Trigger [dbo].[sales_details_insert_upate]    Script Date: 26/06/2023 18:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[sales_details_insert_upate] 
ON [dbo].[sales_details] 
AFTER INSERT
AS
	DECLARE @quantity INT;
	DECLARE @product_id VARCHAR(20);
	DECLARE @product_stock INT;
	
	SELECT @quantity = quantity,
		   @product_id = producto_id
	FROM INSERTED

	SELECT @product_stock = stock FROM products WHERE id = @product_id

	IF(@quantity <= @product_stock) 
		UPDATE products SET stock = stock - @quantity WHERE id  = @product_id
	ELSE
		BEGIN
		RAISERROR('Hay menos en stock de los solicitados', 16,1)
		ROLLBACK TRANSACTION
END
GO
ALTER TABLE [dbo].[sales_details] ENABLE TRIGGER [sales_details_insert_upate]
GO
/****** Object:  Trigger [dbo].[user_after_insert]    Script Date: 26/06/2023 18:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[user_after_insert] 
ON [dbo].[users]
FOR INSERT
AS
BEGIN
	DECLARE @id INT
	
	SELECT @id = i.id FROM INSERTED as i
 	
	INSERT INTO [security] (user_id ) VALUES (@id);
END
GO
ALTER TABLE [dbo].[users] ENABLE TRIGGER [user_after_insert]
GO

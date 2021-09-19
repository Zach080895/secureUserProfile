/****** Object:  Table [dbo].[users]    Script Date: 9/19/2021 3:55:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[users](
	[OID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[phoneNumber] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NOT NULL,
	[address] [nvarchar](250) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[zipCode] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[BirthDate] [datetime] NULL,
	[profileColor] [nvarchar](50) NULL,
	[superAdmin] [bit] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[updatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[OID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



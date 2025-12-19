USE [JobSeeker]
GO

IF OBJECT_ID('[dbo].[HandbookPosts]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[HandbookPosts](
        [HandbookPostID] [int] IDENTITY(1,1) NOT NULL,
        [Title] [nvarchar](255) NOT NULL,
        [Content] [nvarchar](max) NOT NULL,
        [Thumbnail] [nvarchar](255) NULL,
        [Status] [nvarchar](20) NOT NULL,
        [CreatedAt] [datetime2](7) NOT NULL CONSTRAINT [DF_HandbookPosts_CreatedAt] DEFAULT (SYSUTCDATETIME()),
        [UpdatedAt] [datetime2](7) NOT NULL CONSTRAINT [DF_HandbookPosts_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
        CONSTRAINT [PK_HandbookPosts] PRIMARY KEY CLUSTERED ([HandbookPostID] ASC)
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

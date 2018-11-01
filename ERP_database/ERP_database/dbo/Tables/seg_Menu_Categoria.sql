CREATE TABLE [dbo].[seg_Menu_Categoria] (
    [Codigo_Categoria] VARCHAR (50) NOT NULL,
    [Descripcion]      VARCHAR (50) NOT NULL,
    [Visible]          BIT          NOT NULL,
    [Expanded]         BIT          NOT NULL,
    [Color]            VARCHAR (50) NOT NULL,
    [position]         INT          NOT NULL,
    CONSTRAINT [PK_seg_Menu_Ribbon_Categoria] PRIMARY KEY CLUSTERED ([Codigo_Categoria] ASC)
);


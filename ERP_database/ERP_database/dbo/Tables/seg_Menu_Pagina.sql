CREATE TABLE [dbo].[seg_Menu_Pagina] (
    [Codigo_Pagina]    VARCHAR (50) NOT NULL,
    [Descripcion]      VARCHAR (50) NOT NULL,
    [Visible]          BIT          NOT NULL,
    [Expanded]         BIT          NOT NULL,
    [ImageIndex]       INT          NOT NULL,
    [ImageAlign]       VARCHAR (50) NOT NULL,
    [Codigo_Categoria] VARCHAR (50) NOT NULL,
    [position]         INT          NOT NULL,
    CONSTRAINT [PK_seg_Menu_Ribbon_Pagina] PRIMARY KEY CLUSTERED ([Codigo_Pagina] ASC),
    CONSTRAINT [FK_seg_Menu_Pagina_seg_Menu_Categoria] FOREIGN KEY ([Codigo_Categoria]) REFERENCES [dbo].[seg_Menu_Categoria] ([Codigo_Categoria])
);


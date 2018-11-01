CREATE TABLE [dbo].[seg_Menu_Grupo] (
    [Codigo_Grupo]      VARCHAR (50) NOT NULL,
    [Descripcion]       VARCHAR (50) NOT NULL,
    [AllowMinimize]     BIT          NOT NULL,
    [ImageIndex]        INT          NOT NULL,
    [ShowCaptionButton] BIT          NOT NULL,
    [Visible]           BIT          NOT NULL,
    [Codigo_Pagina]     VARCHAR (50) NOT NULL,
    [position]          INT          NOT NULL,
    CONSTRAINT [PK_seg_Menu_Ribbon_Grupo] PRIMARY KEY CLUSTERED ([Codigo_Grupo] ASC),
    CONSTRAINT [FK_seg_Menu_Grupo_seg_Menu_Pagina] FOREIGN KEY ([Codigo_Pagina]) REFERENCES [dbo].[seg_Menu_Pagina] ([Codigo_Pagina])
);


CREATE TABLE [dbo].[seg_Menu_Item] (
    [Codigo_Item]              VARCHAR (50)  NOT NULL,
    [Descripcion]              VARCHAR (50)  NOT NULL,
    [ImageIndex]               INT           NOT NULL,
    [LargeImageIndex]          INT           NULL,
    [ItemShortcut]             VARCHAR (50)  NULL,
    [Enabled]                  BIT           NOT NULL,
    [position]                 INT           NOT NULL,
    [IdTipo_Item]              VARCHAR (50)  NOT NULL,
    [nom_Formulario]           VARCHAR (250) NULL,
    [nom_Asembly]              VARCHAR (250) NULL,
    [CodReporte]               VARCHAR (50)  NULL,
    [Tipo]                     VARCHAR (20)  NOT NULL,
    [Se_muestra_menu_superior] BIT           NOT NULL,
    [Se_muestra_menu_lateral]  BIT           NOT NULL,
    [Visible]                  BIT           NOT NULL,
    CONSTRAINT [PK_seg_Menu_Ribbon_Item] PRIMARY KEY CLUSTERED ([Codigo_Item] ASC),
    CONSTRAINT [FK_seg_Menu_Item_seg_Menu_Item_Tipo] FOREIGN KEY ([IdTipo_Item]) REFERENCES [dbo].[seg_Menu_Item_Tipo] ([IdTipo_Item])
);


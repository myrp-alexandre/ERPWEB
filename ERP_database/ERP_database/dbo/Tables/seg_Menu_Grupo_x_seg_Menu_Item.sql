CREATE TABLE [dbo].[seg_Menu_Grupo_x_seg_Menu_Item] (
    [Codigo_Item]  VARCHAR (50) NOT NULL,
    [Codigo_Grupo] VARCHAR (50) NOT NULL,
    [observacion]  VARCHAR (50) NULL,
    CONSTRAINT [PK_seg_Menu_Ribbon_Grupo_x_seg_Menu_Ribbon_Item] PRIMARY KEY CLUSTERED ([Codigo_Item] ASC, [Codigo_Grupo] ASC),
    CONSTRAINT [FK_seg_Menu_Grupo_x_seg_Menu_Item_seg_Menu_Grupo] FOREIGN KEY ([Codigo_Grupo]) REFERENCES [dbo].[seg_Menu_Grupo] ([Codigo_Grupo]),
    CONSTRAINT [FK_seg_Menu_Grupo_x_seg_Menu_Item_seg_Menu_Item] FOREIGN KEY ([Codigo_Item]) REFERENCES [dbo].[seg_Menu_Item] ([Codigo_Item])
);


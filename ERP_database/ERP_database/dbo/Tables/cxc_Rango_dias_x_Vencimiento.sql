CREATE TABLE [dbo].[cxc_Rango_dias_x_Vencimiento] (
    [Id_Rango]    VARCHAR (20) NOT NULL,
    [Descripcion] VARCHAR (50) NOT NULL,
    [Valor_Ini]   INT          NOT NULL,
    [Valor_Fin]   INT          NOT NULL,
    CONSTRAINT [PK_cxc_Rango_dias_x_Vencimiento] PRIMARY KEY CLUSTERED ([Id_Rango] ASC)
);


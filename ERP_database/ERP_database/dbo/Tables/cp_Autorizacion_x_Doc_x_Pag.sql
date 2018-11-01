CREATE TABLE [dbo].[cp_Autorizacion_x_Doc_x_Pag] (
    [Id_Num_Autorizacion]     VARCHAR (200) NOT NULL,
    [Serie1]                  VARCHAR (5)   NULL,
    [Serie2]                  VARCHAR (5)   NULL,
    [Valido_Hasta]            DATE          NULL,
    [factura_inicial]         VARCHAR (50)  NULL,
    [factura_final]           VARCHAR (50)  NULL,
    [NumAutorizacionImprenta] VARCHAR (50)  NULL,
    CONSTRAINT [PK_cp_Autorizacion_x_Doc_x_Pag] PRIMARY KEY CLUSTERED ([Id_Num_Autorizacion] ASC)
);


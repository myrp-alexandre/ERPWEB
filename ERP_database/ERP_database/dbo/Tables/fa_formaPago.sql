CREATE TABLE [dbo].[fa_formaPago] (
    [IdFormaPago]   VARCHAR (2)   NOT NULL,
    [nom_FormaPago] VARCHAR (500) NOT NULL,
    CONSTRAINT [PK_fa_factura_FormaPago] PRIMARY KEY CLUSTERED ([IdFormaPago] ASC)
);


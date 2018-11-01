CREATE TABLE [dbo].[in_kardex_det] (
    [IdEmpresa]         INT           NOT NULL,
    [IdSucursal]        INT           NOT NULL,
    [IdBodega]          INT           NOT NULL,
    [IdProducto]        NUMERIC (18)  NOT NULL,
    [Secuencia]         NUMERIC (18)  NOT NULL,
    [kr_Motivo]         VARCHAR (30)  NOT NULL,
    [kt_Transaccion]    VARCHAR (50)  NOT NULL,
    [kr_Tipo]           CHAR (1)      NOT NULL,
    [kr_fecha]          DATETIME      NOT NULL,
    [kr_Observacion]    VARCHAR (150) NOT NULL,
    [kr_CostoUni]       FLOAT (53)    NOT NULL,
    [kr_Ent_Cantidad]   FLOAT (53)    NOT NULL,
    [kr_Ent_valor]      FLOAT (53)    NOT NULL,
    [kr_Sali_Cantidad]  FLOAT (53)    NOT NULL,
    [kr_Sali_valor]     FLOAT (53)    NOT NULL,
    [kr_Saldo_Cant]     FLOAT (53)    NOT NULL,
    [kr_Saldo_CostoUni] FLOAT (53)    NOT NULL,
    [kr_Saldo_valor]    FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_in_kardex] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdProducto] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_in_kardex_det_in_kardex] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdProducto]) REFERENCES [dbo].[in_kardex] ([IdEmpresa], [IdSucursal], [IdBodega], [IdProducto]),
    CONSTRAINT [FK_in_kardex_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);


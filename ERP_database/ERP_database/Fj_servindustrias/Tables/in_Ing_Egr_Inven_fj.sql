CREATE TABLE [Fj_servindustrias].[in_Ing_Egr_Inven_fj] (
    [IdEmpresa]               INT          NOT NULL,
    [IdSucursal]              INT          NOT NULL,
    [IdMovi_inven_tipo]       INT          NOT NULL,
    [IdNumMovi]               NUMERIC (18) NOT NULL,
    [cod_orden_mantenimiento] VARCHAR (50) NULL,
    [IdEmpleado]              NUMERIC (18) NULL,
    CONSTRAINT [PK_in_Ing_Egr_Inven_fj] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdMovi_inven_tipo] ASC, [IdNumMovi] ASC),
    CONSTRAINT [FK_in_Ing_Egr_Inven_fj_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado])
);


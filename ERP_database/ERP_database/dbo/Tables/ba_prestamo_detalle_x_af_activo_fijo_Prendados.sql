CREATE TABLE [dbo].[ba_prestamo_detalle_x_af_activo_fijo_Prendados] (
    [IdEmpresa]         INT        NOT NULL,
    [IdPrestamo]        INT        NOT NULL,
    [IdActivoFijo]      INT        NOT NULL,
    [Garantia_Bancaria] FLOAT (53) NULL,
    CONSTRAINT [PK_ba_prestamo_detalle_x_af_activo_fijo_Prendados] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPrestamo] ASC, [IdActivoFijo] ASC)
);


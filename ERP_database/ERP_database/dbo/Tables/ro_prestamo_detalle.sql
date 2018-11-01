CREATE TABLE [dbo].[ro_prestamo_detalle] (
    [IdEmpresa]         INT           NOT NULL,
    [IdPrestamo]        NUMERIC (18)  NOT NULL,
    [NumCuota]          INT           NOT NULL,
    [SaldoInicial]      FLOAT (53)    NOT NULL,
    [Interes]           FLOAT (53)    NOT NULL,
    [AbonoCapital]      FLOAT (53)    NOT NULL,
    [TotalCuota]        FLOAT (53)    NOT NULL,
    [Saldo]             FLOAT (53)    NOT NULL,
    [FechaPago]         DATETIME      NOT NULL,
    [EstadoPago]        VARCHAR (10)  NOT NULL,
    [Estado]            CHAR (1)      NOT NULL,
    [Observacion_det]   VARCHAR (250) NOT NULL,
    [IdNominaTipoLiqui] INT           NOT NULL,
    CONSTRAINT [PK_ro_prestamo_detalle] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPrestamo] ASC, [NumCuota] ASC),
    CONSTRAINT [FK_ro_prestamo_detalle_ro_prestamo] FOREIGN KEY ([IdEmpresa], [IdPrestamo]) REFERENCES [dbo].[ro_prestamo] ([IdEmpresa], [IdPrestamo])
);


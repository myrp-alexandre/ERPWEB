namespace Core.Erp.Info.Facturacion
{
    public class fa_factura_x_cxc_cobro_tipo_Info
    {
        public int IdEmpresa_fa { get; set; }
        public int IdSucursal_fa { get; set; }
        public int IdBodega_fa { get; set; }
        public decimal IdCbteVta_fa { get; set; }
        public int Secuencia { get; set; }
        public string IdCobro_tipo { get; set; }
        public int IdEmpresa_cxc { get; set; }
        public int IdSucursal_cxc { get; set; }
        public decimal IdCobro_cxc { get; set; }
        public double Valor { get; set; }
    }
}

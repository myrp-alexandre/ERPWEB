using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Facturacion
{
    public class FAC_003_Info
    {

        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdCbteVta { get; set; }
        public int Secuencia { get; set; }
        public decimal IdProducto { get; set; }
        public string pr_descripcion { get; set; }
        public double vt_cantidad { get; set; }
        public double vt_Precio { get; set; }
        public double SubtotalSinDscto { get; set; }
        public double DescuentoTotal { get; set; }
        public double SubtotalConDscto { get; set; }
        public double vt_iva { get; set; }
        public double Expr1 { get; set; }
        public double vt_por_iva { get; set; }
        public double SubtotalIVA { get; set; }
        public double SubtotalSinIVA { get; set; }
        public System.DateTime vt_fecha { get; set; }
        public string vt_NumFactura { get; set; }
        public string cli_Nombre { get; set; }
        public string cli_cedulaRuc { get; set; }
        public string cli_direccion { get; set; }
        public string cli_Telefonos { get; set; }
        public string cli_correo { get; set; }
        public string Su_Descripcion { get; set; }
        public string Su_Telefonos { get; set; }
        public string Su_Direccion { get; set; }
        public string FormaDePago { get; set; }
    }
}

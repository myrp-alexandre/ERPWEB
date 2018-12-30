using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Facturacion
{
  public class FAC_010_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdCbteVta { get; set; }
        public string vt_NumFactura { get; set; }
        public decimal IdCliente { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string NombreFormaPago { get; set; }
        public string IdCatalogo_FormaPago { get; set; }
        public string Estado { get; set; }
        public System.DateTime vt_fecha { get; set; }
        public string Ve_Vendedor { get; set; }
        public int IdVendedor { get; set; }
        public string Su_Descripcion { get; set; }
        public string Su_Telefonos { get; set; }
        public string Su_Direccion { get; set; }
        public string Su_Ruc { get; set; }
        public Nullable<double> SubtotalIVA { get; set; }
        public Nullable<double> SubtotalSinIVA { get; set; }
        public Nullable<double> vt_iva { get; set; }
        public Nullable<double> vt_total { get; set; }
    }
}

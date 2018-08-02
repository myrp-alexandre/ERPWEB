using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Facturacion
{
   public class FAC_007_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdCbteVta { get; set; }
        public int Secuencia { get; set; }
        public decimal IdProducto { get; set; }
        public string pr_descripcion { get; set; }
        public string nom_presentacion { get; set; }
        public string lote_num_lote { get; set; }
        public Nullable<System.DateTime> lote_fecha_vcto { get; set; }
        public double vt_cantidad { get; set; }
        public double vt_Precio { get; set; }
        public double vt_PorDescUnitario { get; set; }
        public double vt_Subtotal { get; set; }
        public double DescTotal { get; set; }
        public double vt_SubtotalIVA { get; set; }
        public double vt_Subtotal0 { get; set; }
        public double vt_iva { get; set; }
        public double vt_total { get; set; }
        public double vt_por_iva { get; set; }
        public string Nombres { get; set; }
        public string Su_Descripcion { get; set; }
        public string vt_NumFactura { get; set; }
        public System.DateTime vt_fecha { get; set; }
        public System.DateTime vt_fech_venc { get; set; }
        public string Ve_Vendedor { get; set; }
        public string nom_TerminoPago { get; set; }
        public int Num_Coutas { get; set; }
        public string vt_Observacion { get; set; }
    }
}

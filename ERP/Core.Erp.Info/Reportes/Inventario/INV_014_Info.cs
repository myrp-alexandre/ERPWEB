using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Inventario
{
    public class INV_014_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdConsignacion { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public DateTime Fecha { get; set; }
        public int IdProveedor { get; set; }
        public string Observacion { get; set; }
        public bool Estado { get; set; }
        public int Secuencia { get; set; }
        public decimal IdProducto { get; set; }
        public string IdUnidadMedida { get; set; }
        public double Cantidad { get; set; }
        public double Costo { get; set; }
        public string ObservacionDet { get; set; }
        public string pr_descripcion { get; set; }
        public string pr_codigo { get; set; }
        public int IdPersona { get; set; }
        public string pe_nombre_Completo { get; set; }
        public string pe_nombre { get; set; }
        public string pe_apellido { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Facturacion
{
   public class fa_catalogo_Info
    {
        public string IdCatalogo { get; set; }
        public int IdCatalogo_tipo { get; set; }
        public string Nombre { get; set; }
        public string Estado { get; set; }
        public string Abrebiatura { get; set; }
        public string NombreIngles { get; set; }
        public Nullable<int> Orden { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> FechaUltMod { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string MotiAnula { get; set; }
    }
}

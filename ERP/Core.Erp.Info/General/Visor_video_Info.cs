using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.General
{
   public class Visor_video_Info
    {
        public string Cod_video { get; set; }
        public string Nombre_video { get; set; }
        public bool Estado { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> FechaTransaccion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string IdUsuarioModifica { get; set; }
        public string IdUsuarioAnulacion { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_DocumentoxEmp_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public decimal IdDocumento { get; set; }
        public string Dc_Nombre { get; set; }
        public string Dc_Descripcion { get; set; }
        public byte[] Documento { get; set; }
        public string tipo { get; set; }
        public System.DateTime FechaReg { get; set; }
        public Nullable<System.DateTime> FechaElimin { get; set; }
        public string UsuarioElimin { get; set; }
        public string MotivoElimin { get; set; }
        public string Estado { get; set; }

    }
}

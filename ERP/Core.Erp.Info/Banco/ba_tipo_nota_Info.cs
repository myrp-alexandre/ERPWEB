using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Banco
{
    public class ba_tipo_nota_Info
    {
        public int IdEmpresa { get; set; }
        public int IdTipoNota { get; set; }
        public string Tipo { get; set; }
        public string Descripcion { get; set; }
        public string IdCtaCble { get; set; }
        public string IdCentroCosto { get; set; }
        public string Estado { get; set; }
    }
}

using Core.Erp.Info.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Importacion
{
    public class imp_catalogo_tipo_Data
    {
        public List<imp_catalogo_tipo_Info> get_list(int IdCatalogo_tipo)
        {
            try
            {
                List<imp_catalogo_tipo_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.imp_catalogo_tipo
                             where q.IdCatalogo_tipo == IdCatalogo_tipo
                             select new imp_catalogo_tipo_Info
                             {
                                 IdCatalogo_tipo = q.IdCatalogo_tipo,
                                 ct_descripcion = q.ct_descripcion,
                                 estado = q.estado == true
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}

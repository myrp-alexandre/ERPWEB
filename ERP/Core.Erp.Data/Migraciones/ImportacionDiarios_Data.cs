using Core.Erp.Info.Migraciones;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Migraciones
{
    public class ImportacionDiarios_Data
    {
        public List<ImportacionDiarios_Info> get_list(string TipoDocumento)
        {
            try
            {
                List<ImportacionDiarios_Info> Lista;
                using (DBSACEntities Context = new DBSACEntities())
                {
                    Lista = (from q in Context.vw_diarios_contables_migracion
                             where q.tipo_documento == TipoDocumento
                             select new ImportacionDiarios_Info
                             {
                                 Empresa = q.Empresa,
                                 centro = q.centro,
                                 Numero = q.Numero,
                                 Secuencia = q.Secuencia,
                                 Fecha = q.Fecha,
                                 Valor = q.Valor,
                                 TipoMov = q.TipoMov,
                                 Glosa = q.Glosa,
                                 Detalle = q.Detalle,
                                 tipo_documento = q.tipo_documento,
                                 IdCtaCble = q.IdCtaCble,
                                 dc_Valor = q.dc_Valor,
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

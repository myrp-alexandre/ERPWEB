using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
   public class tb_banco_procesos_bancarios_x_empresa_Data
    {
        public List<tb_banco_procesos_bancarios_x_empresa_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<tb_banco_procesos_bancarios_x_empresa_Info> Lista;
                using (Entities_general Context = new Entities_general())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.tb_banco_procesos_bancarios_x_empresa
                                 select new tb_banco_procesos_bancarios_x_empresa_Info
                                 {
                                     IdEmpresa=q.IdEmpresa,
                                     IdBanco = q.IdBanco,
                                     IdProceso_bancario_tipo = q.IdProceso_bancario_tipo,
                                     IdTipoNota = q.IdTipoNota,
                                     Se_contabiliza = q.Se_contabiliza
                                 }).ToList();
                    else
                        Lista = (from q in Context.tb_banco_procesos_bancarios_x_empresa
                                 select new tb_banco_procesos_bancarios_x_empresa_Info
                                 {
                                     IdEmpresa=q.IdEmpresa,
                                     IdBanco = q.IdBanco,
                                     IdProceso_bancario_tipo = q.IdProceso_bancario_tipo,
                                     IdTipoNota = q.IdTipoNota,
                                     Se_contabiliza = q.Se_contabiliza

                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public tb_banco_procesos_bancarios_x_empresa_Info get_info(int IdBanco)
        {
            try
            {
                tb_banco_procesos_bancarios_x_empresa_Info info = new tb_banco_procesos_bancarios_x_empresa_Info();
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco_procesos_bancarios_x_empresa Entity = Context.tb_banco_procesos_bancarios_x_empresa.FirstOrDefault(q => q.IdBanco == IdBanco);
                    if (Entity == null) return null;

                    info = new tb_banco_procesos_bancarios_x_empresa_Info
                    {
                        IdBanco = Entity.IdBanco,
                        IdProceso_bancario_tipo = Entity.IdProceso_bancario_tipo,
                        estado = Entity.estado,
                        Codigo_Empresa = Entity.Codigo_Empresa,

                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private int get_id()
        {
            try
            {
                int ID = 1;
                using (Entities_general Context = new Entities_general())
                {
                    var lst = from q in Context.tb_banco_procesos_bancarios_x_empresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdBanco) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(tb_banco_procesos_bancarios_x_empresa_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco_procesos_bancarios_x_empresa Entity = new tb_banco_procesos_bancarios_x_empresa
                    {
                        IdProceso = info.IdProceso = get_id(),
                        IdProceso_bancario_tipo = info.IdProceso_bancario_tipo,
                        Codigo_Empresa = info.Codigo_Empresa,
                        estado = info.estado="A",
                        IdTipoNota = info.IdTipoNota,
                        Se_contabiliza=info.Se_contabiliza
                    };
                    Context.tb_banco_procesos_bancarios_x_empresa.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool modificarDB(tb_banco_procesos_bancarios_x_empresa_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco_procesos_bancarios_x_empresa Entity = Context.tb_banco_procesos_bancarios_x_empresa.FirstOrDefault(q => q.IdBanco == info.IdBanco);
                    if (Entity == null)
                        return false;
                    Entity.IdProceso_bancario_tipo = info.IdProceso_bancario_tipo;
                    Entity.Codigo_Empresa = info.Codigo_Empresa;
                    Entity.Se_contabiliza = info.Se_contabiliza;
                    Entity.IdTipoNota = info.IdTipoNota;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(tb_banco_procesos_bancarios_x_empresa_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco_procesos_bancarios_x_empresa Entity = Context.tb_banco_procesos_bancarios_x_empresa.FirstOrDefault(q => q.IdProceso == info.IdProceso&& q.IdEmpresa==info.IdEmpresa);
                    if (Entity == null)
                        return false;
                    Entity.estado = info.estado = "I";
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}

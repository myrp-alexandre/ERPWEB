using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
    public class tb_banco_Data
    {
        public List<tb_banco_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<tb_banco_Info> Lista;
                using (Entities_general Context = new Entities_general())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.tb_banco
                             select new tb_banco_Info
                             {
                                 IdBanco = q.IdBanco,
                                 ba_descripcion = q.ba_descripcion,
                                 Estado = q.Estado,
                                 CodigoLegal = q.CodigoLegal
                             }).ToList();
                    else
                        Lista = (from q in Context.tb_banco
                                 where q.Estado == "A"
                                 select new tb_banco_Info
                                 {
                                     IdBanco = q.IdBanco,
                                     ba_descripcion = q.ba_descripcion,
                                     Estado = q.Estado,
                                     CodigoLegal = q.CodigoLegal
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public tb_banco_Info get_info(int IdBanco)
        {
            try
            {
                tb_banco_Info info = new tb_banco_Info();
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco Entity = Context.tb_banco.FirstOrDefault(q => q.IdBanco == IdBanco);
                    if (Entity == null) return null;

                    info = new tb_banco_Info
                    {
                        IdBanco = Entity.IdBanco,
                        ba_descripcion = Entity.ba_descripcion,
                        Estado = Entity.Estado,
                        CodigoLegal = Entity.CodigoLegal,
                        TieneFormatoTransferencia = Entity.TieneFormatoTransferencia

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
                    var lst = from q in Context.tb_banco
                             select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdBanco) +1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(tb_banco_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco Entity = new tb_banco
                    {
                        IdBanco = info.IdBanco = get_id(),
                        ba_descripcion = info.ba_descripcion,
                        Estado = info.Estado = "A",
                        CodigoLegal = info.CodigoLegal,
                        TieneFormatoTransferencia = info.TieneFormatoTransferencia
                    };
                    Context.tb_banco.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool modificarDB(tb_banco_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco Entity = Context.tb_banco.FirstOrDefault(q => q.IdBanco == info.IdBanco);
                    if (Entity == null)
                        return false;
                    Entity.CodigoLegal = info.CodigoLegal;
                    Entity.ba_descripcion = info.ba_descripcion;
                    Entity.TieneFormatoTransferencia = info.TieneFormatoTransferencia;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(tb_banco_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_banco Entity = Context.tb_banco.FirstOrDefault(q => q.IdBanco == info.IdBanco);
                    if (Entity == null)
                        return false;
                    Entity.Estado = info.Estado = "I";
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
